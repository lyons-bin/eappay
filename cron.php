<?php
$nosession = true;
require './includes/common.php';

if (function_exists("set_time_limit"))
{
	@set_time_limit(0);
}
if (function_exists("ignore_user_abort"))
{
	@ignore_user_abort(true);
}

@header('Content-Type: text/html; charset=UTF-8');

if(empty($conf['cronkey']))exit("请先设置好监控密钥");
if($conf['cronkey']!=$_GET['key'])exit("监控密钥不正确");

if($_GET['do']=='settle'){
	$settle_time=getSetting('settle_time', true);
	if(strtotime($settle_time)>=strtotime(date("Y-m-d").' 00:00:00'))exit('自动生成结算列表今日已完成');
	$rs=$DB->query("SELECT * from pre_user where money>={$conf['settle_money']} and settle=1 and status=1 and account is not null and username is not null");
	$i=0;
	$allmoney=0;
	while($row = $rs->fetch())
	{
		if($conf['cert_force']==1 && $row['cert']==0){
			continue;
		}
		$i++;
		$settle_rate = $conf['settle_rate'];
		$group = getGroupConfig($row['gid']);
		if(isset($group['settle_open']) && $group['settle_open'] > 0){
			if($group['settle_open'] == 2) continue;
		}elseif($conf['settle_open']!=1 && $conf['settle_open']!=3) continue;
		if(isset($group['settle_rate'])) $settle_rate = $group['settle_rate'];
		if(is_numeric($row['remain_money']) && $row['remain_money'] > 0){
			$row['money'] = round($row['money'] - $row['remain_money'], 2);
		}
		if($row['money']<$conf['settle_money']) continue;
		if($settle_rate>0){
			$fee=round($row['money']*$settle_rate/100,2);
			if(!empty($conf['settle_fee_min']) && $fee<$conf['settle_fee_min'])$fee=$conf['settle_fee_min'];
			if(!empty($conf['settle_fee_max']) && $fee>$conf['settle_fee_max'])$fee=$conf['settle_fee_max'];
			$realmoney=$row['money']-$fee;
		}else{
			$realmoney=$row['money'];
		}
		$data = ['uid'=>$row['uid'], 'type'=>$row['settle_id'], 'account'=>$row['account'], 'username'=>$row['username'], 'money'=>$row['money'], 'realmoney'=>$realmoney, 'addtime'=>'NOW()', 'status'=>0];
		if($DB->insert('settle', $data)){
			changeUserMoney($row['uid'], $row['money'], false, '自动结算');
			$allmoney+=$realmoney;
		}
	}
	saveSetting('settle_time', $date);
	exit('自动生成结算列表成功 allmony='.$allmoney.' num='.$i);
}
elseif($_GET['do']=='order'){
	$order_time=getSetting('order_time', true);
	if(strtotime($order_time)>=strtotime(date("Y-m-d").' 00:00:00')){
		echo '订单统计与清理任务今日已完成';
		if($conf['wxnotice_tpl_balance'] || $conf['msgconfig_balance']){
			$rs=$DB->query("SELECT * from pre_user where status=1");
			$i=0;
			while($row = $rs->fetch())
			{
				$row['msgconfig'] = unserialize($row['msgconfig']);
				if($row['msgconfig']['balance'] > 0 && $row['msgconfig']['balance_money'] > 0 && $row['money'] < $row['msgconfig']['balance_money']){
					$day = $CACHE->read('balance_notice_'.$row['uid']);
					if($day && $day == date('Ymd')) continue;
					\lib\MsgNotice::send('balance', $row['uid'], ['user'=>$row['uid'], 'time'=>date('Y-m-d H:i:s'), 'money'=>$row['money']]);
					$CACHE->save('balance_notice_'.$row['uid'], date('Ymd'), 86400);
					$i++;
				}
			}
			if($i > 0) echo '，余额不足提醒已发送给'.$i.'位商户';
		}
		exit;
	}

	$thtime=date("Y-m-d H:i:s",time()-3600*24);

	$CACHE->clean();
	$DB->exec("delete from pre_order where status=0 and addtime<'{$thtime}'");
	$DB->exec("delete from pre_regcode where `time`<'".(time()-3600*24)."'");
	$DB->exec("delete from pre_blacklist where endtime is not null and endtime<NOW()");
	$DB->exec("delete from pay_wxkflog where addtime<'".date("Y-m-d H:i:s", strtotime('-48 hours'))."'");

	$day = date("Ymd", strtotime("-1 day"));

	$paytype = [];
	$rs = $DB->getAll("SELECT id,name,showname FROM pre_type WHERE status=1");
	foreach($rs as $row){
		$paytype[$row['id']] = $row['showname'];
	}
	unset($rs);

	$channel = [];
	$rs = $DB->getAll("SELECT id,name FROM pre_channel WHERE status=1");
	foreach($rs as $row){
		$channel[$row['id']] = $row['name'];
	}
	unset($rs);

	$lastday=date("Y-m-d",strtotime("-1 day"));
	$today=date("Y-m-d");

	$rs=$DB->query("SELECT type,channel,realmoney,profitmoney from pre_order where status=1 and date>='$lastday' and date<'$today'");
	foreach($paytype as $id=>$type){
		$order_paytype[$id]=0;
		$profit_paytype[$id]=0;
	}
	foreach($channel as $id=>$type){
		$order_channel[$id]=0;
	}
	while($row = $rs->fetch())
	{
		$order_paytype[$row['type']]+=$row['realmoney'];
		$order_channel[$row['channel']]+=$row['realmoney'];
		if(!empty($row['profitmoney'])){
			$profit_paytype[$row['type']]+=$row['profitmoney'];
		}
	}
	foreach($order_paytype as $k=>$v){
		$order_paytype[$k] = round($v,2);
	}
	foreach($order_channel as $k=>$v){
		$order_channel[$k] = round($v,2);
	}
	foreach($profit_paytype as $k=>$v){
		$profit_paytype[$k] = round($v,2);
	}
	$allmoney=0;
	foreach($order_paytype as $money){
		$allmoney+=$money;
	}
	$allprofit=0;
	foreach($profit_paytype as $money){
		$allprofit+=$money;
	}

	$order_lastday['all']=round($allmoney,2);
	$order_lastday['profit_all']=round($allprofit,2);
	$order_lastday['paytype']=$order_paytype;
	$order_lastday['channel']=$order_channel;
	$order_lastday['profit_paytype']=$profit_paytype;

	$CACHE->save('order_'.$day, serialize($order_lastday), 604830);

	saveSetting('order_time', $date);

	$DB->exec("update pre_channel set daystatus=0");

	$expire_users = $DB->getAll("SELECT uid,gid,status,endtime FROM pre_user WHERE gid>0 AND endtime>0 AND endtime<NOW()");
	foreach($expire_users as $row){
		$group = $DB->getRow("SELECT * FROM pre_group WHERE gid='{$row['gid']}'");
		$gid = $group['orig'] > 0 ? $group['orig'] : 0;
		$DB->exec("UPDATE pre_user SET gid={$gid},endtime=NULL WHERE uid='{$row['uid']}'");
		if($row['status'] == 1){
			\lib\MsgNotice::send('group', $row['uid'], ['uid'=>$row['uid'], 'group'=>$group['name'], 'endtime'=>$row['endtime']]);
		}
	}
	exit($day.'订单统计与清理任务执行成功');
}
elseif($_GET['do']=='notify'){
	$limit = 20; //每次重试的订单数量
	for($i=0;$i<$limit;$i++){
		$srow=$DB->getRow("SELECT * FROM pre_order WHERE (TO_DAYS(NOW()) - TO_DAYS(endtime) <= 1) AND notify>0 AND notifytime<NOW() LIMIT 1");
		if(!$srow)break;

		//通知时间：1分钟，3分钟，20分钟，1小时，2小时
		$notify = $srow['notify'] + 1;
		if($notify == 2){
			$interval = '2 minute';
		}elseif($notify == 3){
			$interval = '16 minute';
		}elseif($notify == 4){
			$interval = '36 minute';
		}elseif($notify == 5){
			$interval = '1 hour';
		}else{
			$DB->exec("UPDATE pre_order SET notify=-1,notifytime=NULL WHERE trade_no='{$srow['trade_no']}'");
			continue;
		}
		$DB->exec("UPDATE pre_order SET notify={$notify},notifytime=date_add(now(), interval {$interval}) WHERE trade_no='{$srow['trade_no']}'");

		$url=creat_callback($srow);
		if(do_notify($url['notify'])){
			$DB->exec("UPDATE pre_order SET notify=0,notifytime=NULL WHERE trade_no='{$srow['trade_no']}'");
			echo $srow['trade_no'].' 重新通知成功<br/>';
		}else{
			echo $srow['trade_no'].' 重新通知失败（第'.$notify.'次）<br/>';
			if($conf['auto_check_notify'] == 1){
				$count = intval($conf['check_notify_count']);
				if($count > 0){
					$userrow = $DB->find('user', 'uid,email,pay', ['uid'=>$srow['uid']]);
					if($userrow['pay'] == 1){
						$orders = $DB->getAll("SELECT trade_no FROM pre_order WHERE uid='{$srow['uid']}' and status>0 order by trade_no desc limit {$count}");
						$failcount = 0;
						foreach($orders as $order){
							if($order['notify'] > 0) $failcount++;
						}
						if($failcount >= $count){
							$DB->exec("UPDATE pre_user SET pay=0 WHERE uid='{$srow['uid']}'");
							echo 'UID:'.$srow['uid'].' 连续'.$failcount.'个订单通知失败，已关闭支付权限<br/>';
							$DB->exec("INSERT INTO `pre_risk` (`uid`, `type`, `content`, `date`) VALUES (:uid, 2, :content, NOW())", [':uid'=>$srow['uid'],':content'=>'连续'.$failcount.'个订单']);
							if($conf['check_notify_notice'] == 1){
								send_mail($userrow['email'],$conf['sitename'].' - 商户支付权限关闭提醒','尊敬的用户：你的商户ID '.$userrow['uid'].' 因连续'.$failcount.'个订单回调通知失败，已被系统自动关闭支付权限！请自行检查你的网站是否有防CC防火墙、WAF等，导致支付回调拦截。如有疑问请联系网站客服。<br/>----------<br/>'.$conf['sitename'].'<br/>'.date('Y-m-d H:i:s'));
							}
						}
					}
				}
			}
		}
	}
	echo 'ok!';
}
elseif($_GET['do']=='notify2'){
	$limit = 20; //每次重试的订单数量
	for($i=0;$i<$limit;$i++){
		$srow=$DB->getRow("SELECT * FROM pre_order WHERE (TO_DAYS(NOW()) - TO_DAYS(endtime) <= 1) AND notify=-1 LIMIT 1");
		if(!$srow)break;

		$url=creat_callback($srow);
		if(do_notify($url['notify'])){
			$DB->exec("UPDATE pre_order SET notify=0,notifytime=NULL WHERE trade_no='{$srow['trade_no']}'");
			echo $srow['trade_no'].' 重新通知成功<br/>';
		}else{
			echo $srow['trade_no'].' 重新通知失败<br/>';
		}
	}
	echo 'ok!';
}
elseif($_GET['do']=='profitsharing'){
	\lib\ProfitSharing\CommUtil::task();

	\lib\Payment::settle_task();
	echo 'ok!';
}
elseif($_GET['do']=='check'){
	if($conf['auto_check_channel'] == 1){
		$second = intval($conf['check_channel_second']);
		$failcount = intval($conf['check_channel_failcount']);
		$channelids = trim($conf['check_channel_ids']);
		if($second==0 || $failcount==0)exit('未开启支付通道检查功能');
		if(!empty($channelids)){
			$channels = $DB->getAll("SELECT * FROM pre_channel WHERE id IN ($channelids) AND status=1 ORDER BY id ASC");
		}else{
			$channels = $DB->getAll("SELECT * FROM pre_channel WHERE status=1 ORDER BY id ASC");
		}
		foreach($channels as $channel){
			$channelid = $channel['id'];
			if(strpos($channel['config'], '[') && strpos($channel['config'], ']') && $DB->getCount("SELECT COUNT(*) FROM pre_subchannel WHERE channel='$channelid' AND status=1") > 0){
				$subchannels = $DB->getAll("SELECT * FROM pre_subchannel WHERE channel='$channelid' AND status=1 ORDER BY id ASC");
				foreach($subchannels as $subchannel){
					$subchannelid = $subchannel['id'];
					$orders=$DB->getAll("SELECT trade_no,status FROM pre_order WHERE addtime>=DATE_SUB(NOW(), INTERVAL {$second} SECOND) AND channel='$channelid' AND subchannel='$subchannelid' order by trade_no desc limit {$failcount}");
					if(count($orders)<$failcount)continue;
					$succount = 0;
					foreach($orders as $order){
						if($order['status']>0) $succount++;
					}
					if($succount == 0){
						$DB->exec("UPDATE pre_subchannel SET status=0 WHERE id='$subchannelid'");
						echo '已关闭子通道:'.$subchannel['name'].'<br/>';
						if($conf['check_channel_notice'] == 1){
							$mail_name = $conf['mail_recv']?$conf['mail_recv']:$conf['mail_name'];
							send_mail($mail_name,$conf['sitename'].' - 支付通道自动关闭提醒','尊敬的管理员：支付通道“'.$channel['name'].'”下的子通道“'.$subchannel['name'].'”因在'.$second.'秒内连续出现'.$failcount.'个未支付订单，已被系统自动关闭！<br/>----------<br/>'.$conf['sitename'].'<br/>'.date('Y-m-d H:i:s'));
						}
					}
				}
			}else{
				$orders=$DB->getAll("SELECT trade_no,status FROM pre_order WHERE addtime>=DATE_SUB(NOW(), INTERVAL {$second} SECOND) AND channel='$channelid' order by trade_no desc limit {$failcount}");
				if(count($orders)<$failcount)continue;
				$succount = 0;
				foreach($orders as $order){
					if($order['status']>0) $succount++;
				}
				if($succount == 0){
					$DB->exec("UPDATE pre_channel SET status=0 WHERE id='$channelid'");
					echo '已关闭通道:'.$channel['name'].'<br/>';
					if($conf['check_channel_notice'] == 1){
						$mail_name = $conf['mail_recv']?$conf['mail_recv']:$conf['mail_name'];
						send_mail($mail_name,$conf['sitename'].' - 支付通道自动关闭提醒','尊敬的管理员：支付通道“'.$channel['name'].'”因在'.$second.'秒内连续出现'.$failcount.'个未支付订单，已被系统自动关闭！<br/>----------<br/>'.$conf['sitename'].'<br/>'.date('Y-m-d H:i:s'));
					}
				}
			}
		}
		echo '支付通道检查任务已完成<br/>';
	}
	if($conf['auto_check_sucrate'] == 1){
		$second = intval($conf['check_sucrate_second']);
		$count = intval($conf['check_sucrate_count']);
		$sucrate = floatval($conf['check_sucrate_value']);
		if($second==0 || $count==0 || $sucrate==0)exit('未开启商户订单成功率检查功能');
		//统计指定时间内每个商户的总订单数量
		$user_all_stats_rows=$DB->getAll("SELECT uid,count(*) ordernum FROM pre_order WHERE addtime>=DATE_SUB(NOW(), INTERVAL {$second} SECOND) GROUP BY uid");
		//统计指定时间内每个商户的成功订单数量
		$user_suc_stats_rows=$DB->getAll("SELECT uid,count(*) ordernum FROM pre_order WHERE addtime>=DATE_SUB(NOW(), INTERVAL {$second} SECOND) and status>0 GROUP BY uid");
		$user_suc_stats = [];
		foreach($user_suc_stats_rows as $row){
			if(!$row['uid']) continue;
			$user_suc_stats[$row['uid']] = $row['ordernum'];
		}
		foreach($user_all_stats_rows as $row){
			if(!$row['uid']) continue;
			$total_num = intval($row['ordernum']);
			$succ_num = intval($user_suc_stats[$row['uid']]);
			$user_rate = round($succ_num * 100 / $total_num, 2);
			if($total_num >= $count && $user_rate < $sucrate){
				$userrow = $DB->find('user', 'uid,email,pay', ['uid'=>$row['uid']]);
				if($userrow['pay'] == 1){
					$DB->exec("UPDATE pre_user SET pay=0 WHERE uid='{$row['uid']}'");
					echo 'UID:'.$row['uid'].' 订单成功率'.$user_rate.'%（'.$succ_num.'/'.$total_num.'），已关闭支付权限<br/>';
					$DB->exec("INSERT INTO `pre_risk` (`uid`, `type`, `content`, `date`) VALUES (:uid, 1, :content, NOW())", [':uid'=>$row['uid'],':content'=>$user_rate.'%（'.$succ_num.'/'.$total_num.'）']);
					if($conf['check_sucrate_notice'] == 1){
						send_mail($userrow['email'],$conf['sitename'].' - 商户支付权限关闭提醒','尊敬的用户：你的商户ID '.$userrow['uid'].' 因在'.$second.'秒内订单支付成功率低于'.$sucrate.'%，已被系统自动关闭支付权限！如有疑问请联系网站客服。<br/>当前订单支付成功率：'.$user_rate.'%（总订单数：'.$succ_num.'，成功订单数：'.$total_num.'）<br/>----------<br/>'.$conf['sitename'].'<br/>'.date('Y-m-d H:i:s'));
					}
				}
			}
		}
		echo '商户订单成功率检查任务已完成<br/>';
	}
	if($conf['auto_check_complain'] == 1){
		$complain_rate = floatval($conf['check_complain_rate']);
		$complain_stats_rows = $DB->getAll("SELECT uid,count(*) num FROM pre_complain WHERE addtime>=DATE_SUB(NOW(), INTERVAL 7 DAY) AND uid<>0 GROUP BY uid");
		if(!empty($complain_stats_rows)){
			$complain_stats = [];
			foreach($complain_stats_rows as $row){
				$complain_stats[$row['uid']] = $row['num'];
			}
			$uids = [];
			foreach($complain_stats_rows as $row){
				$uids[] = $row['uid'];
			}
			$user_order_stats_rows=$DB->getAll("SELECT uid,count(*) ordernum FROM pre_order WHERE addtime>=DATE_SUB(NOW(), INTERVAL 7 DAY) and status>0 and uid in (".implode(',',$uids).") GROUP BY uid");
			foreach($user_order_stats_rows as $row){
				if(!isset($complain_stats[$row['uid']])) continue;
				$total_num = intval($row['ordernum']);
				if($total_num == 0) continue;
				$complain_num = intval($complain_stats[$row['uid']]);
				$user_rate = round($complain_num * 100 / $total_num, 2);
				if($complain_num > 0 && $user_rate > $complain_rate){
					$userrow = $DB->find('user', 'uid,email,pay', ['uid'=>$row['uid']]);
					if($userrow['pay'] == 1){
						$DB->exec("UPDATE pre_user SET pay=0 WHERE uid='{$row['uid']}'");
						echo 'UID:'.$row['uid'].' 投诉率'.$user_rate.'%（'.$complain_num.'/'.$total_num.'），已关闭支付权限<br/>';
						$DB->exec("INSERT INTO `pre_risk` (`uid`, `type`, `content`, `date`) VALUES (:uid, 3, :content, NOW())", [':uid'=>$row['uid'],':content'=>$user_rate.'%（'.$complain_num.'/'.$total_num.'）']);
						if($conf['check_complain_notice'] == 1){
							send_mail($userrow['email'],$conf['sitename'].' - 商户支付权限关闭提醒','尊敬的用户：你的商户ID '.$userrow['uid'].' 因在7天内订单投诉率高于'.$complain_rate.'%，已被系统自动关闭支付权限！如有疑问请联系网站客服。<br/>当前订单投诉率：'.$user_rate.'%（7天总订单数：'.$total_num.'，投诉订单数：'.$complain_num.'）<br/>----------<br/>'.$conf['sitename'].'<br/>'.date('Y-m-d H:i:s'));
						}
					}
				}
			}
		}
		echo '商户订单投诉率检查任务已完成<br/>';
	}
	if($conf['auto_check_payip'] == 1){
		$second = intval($conf['check_payip_second']);
		$count = intval($conf['check_payip_count']);
		if($second==0 || $count==0)exit('未开启单个IP连续未支付订单数量检查功能');
		//统计指定时间内每个商户的总订单数量
		$ip_all_stats_rows=$DB->getAll("SELECT ip,count(*) ordernum FROM pre_order WHERE addtime>=DATE_SUB(NOW(), INTERVAL {$second} SECOND) GROUP BY ip");
		//统计指定时间内每个商户的成功订单数量
		$ip_suc_stats_rows=$DB->getAll("SELECT ip,count(*) ordernum FROM pre_order WHERE addtime>=DATE_SUB(NOW(), INTERVAL {$second} SECOND) and status>0 GROUP BY ip");
		$ip_suc_stats = [];
		foreach($ip_suc_stats_rows as $row){
			if(!$row['ip']) continue;
			$ip_suc_stats[$row['ip']] = $row['ordernum'];
		}
		foreach($ip_all_stats_rows as $row){
			if($row['ordernum'] < $count) continue;
			$succ_num = intval($ip_suc_stats[$row['ip']]);
			if($succ_num > 0) continue;
			$black = $DB->getRow("select * from pre_blacklist where type=1 and content=:content limit 1", [':content'=>$row['ip']]);
			if($black){
				if(!$black['endtime'] || strtotime($black['endtime'])>strtotime('+4 days')) continue;
				$DB->update('blacklist', ['endtime'=>date('Y-m-d H:i:s', strtotime('+5 days')), 'remark'=>'连续'.$row['ordernum'].'个订单未支付'], ['id'=>$black['id']]);
			}else{
				$DB->insert('blacklist', ['type'=>1, 'content'=>$row['ip'], 'addtime'=>'NOW()', 'endtime'=>date('Y-m-d H:i:s', strtotime('+5 days')), 'remark'=>'连续'.$row['ordernum'].'个订单未支付']);
			}
			echo 'IP:'.$row['ip'].' 连续'.$row['ordernum'].'个订单未支付，已加入黑名单<br/>';
		}
		echo '单个IP连续未支付订单数量检查任务已完成<br/>';
	}
}
elseif($_GET['do']=='complain'){
	$channelid = intval($_GET['channel']);
	$source = isset($_GET['source'])?intval($_GET['source']):1;
	$num = 20;
	$channel=\lib\Channel::get($channelid);
	if(!$channel)exit('当前支付通道不存在');
	$channel['source'] = $source;
	if($channel['plugin'] == 'alipaysl' && substr($channel['appmchid'],0,1)=='['){
		$uid = [];
		$subchannels = [];
		$orders = $DB->getAll("SELECT DISTINCT uid,subchannel FROM pre_order WHERE channel='$channelid' AND date>='".date("Y-m-d",strtotime("-7 day"))."'");
		foreach($orders as $row){
			if(!in_array($row['uid'], $uid) && $row['subchannel'] == 0)$uid[] = $row['uid'];
			if($row['subchannel'] > 0)$subchannels[] = $row['subchannel'];
		}
		$exist = false;
		if(count($uid)>0){
			$users = $DB->getAll("SELECT uid,channelinfo FROM pre_user WHERE uid IN (".implode(',',$uid).")");
			foreach($users as $user){
				if(empty($user['channelinfo'])) continue;
				$channel=\lib\Channel::get($channelid, $user['channelinfo']);
				$channel['source'] = $source;
				$model = \lib\Complain\CommUtil::getModel($channel);
				$result = $model->refreshNewList($num);
				echo $user['uid'].':'.$result['msg'].'<br/>';
			}
			$exist = true;
		}
		if(count($subchannels)>0){
			foreach($subchannels as $subchannel){
				$channel=\lib\Channel::getSub($subchannel);
				$channel['source'] = $source;
				$model = \lib\Complain\CommUtil::getModel($channel);
				$result = $model->refreshNewList($num);
				echo $user['uid'].':'.$result['msg'].'<br/>';
			}
			$exist = true;
		}
		if(!$exist)exit('当前支付通道暂无订单');
		exit;
	}
	$model = \lib\Complain\CommUtil::getModel($channel);
	if(!$model)exit('不支持该支付插件');
	$result = $model->refreshNewList($num);
	echo $result['msg'];
}
elseif($_GET['do']=='complain_complete'){
	$interval = 5 * 60; //延迟处理时间（秒）
	$limit = 10; //每次处理的投诉数量
	$complain = $DB->getAll("SELECT * FROM pre_complain WHERE status=1 AND paytype=2 AND edittime<DATE_SUB(NOW(), INTERVAL {$interval} SECOND) AND addtime>DATE_SUB(NOW(), INTERVAL 3 DAY) ORDER BY id ASC LIMIT {$limit}");
	foreach($complain as $row){
		$channel = \lib\Channel::get($row['channel']);
		if(!$channel)continue;
		$channel['thirdmchid'] = $row['thirdmchid'];
		$model = \lib\Complain\CommUtil::getModel($channel);
		if(!$model)continue;
		$result = $model->complete($row['thirdid']);
		if($result['code'] == 0){
			$DB->exec("UPDATE pre_complain SET status=1 WHERE id='{$row['id']}'");
			echo '投诉单号：'.$row['thirdid'].' 处理成功<br/>';
		}else{
			echo '投诉单号：'.$row['thirdid'].' 处理失败，原因：'.$result['msg'].'<br/>';
		}
	}
	echo '投诉自动处理('.count($complain).')';
}
elseif($_GET['do']=='plugin'){
	$channelid = isset($_GET['channel'])?intval($_GET['channel']):0;
	$channel = \lib\Channel::get($channelid);
	if(!$channel) exit('当前支付通道不存在');
	try{
		\lib\Plugin::loadForAdmin('_cron');
	}catch(Exception $e){
		echo $e->getMessage();
	}
}
elseif($_GET['do']=='transfer'){
	if(!$conf['auto_settle_money']) exit('未开启自动结算转账功能');
	if(!$conf['transfer_alipay']) exit('未设置支付宝转账接口通道');
	$payee_err_code = [ //收款方原因导致的失败编码
		'PAYEE_NOT_EXIST','PAYEE_ACCOUNT_STATUS_ERROR','CARD_BIN_ERROR','PAYEE_CARD_INFO_ERROR','PERM_AML_NOT_REALNAME_REV','PAYEE_USER_INFO_ERROR','PAYEE_ACC_OCUPIED','PERMIT_NON_BANK_LIMIT_PAYEE','PAYEE_TRUSTEESHIP_ACC_OVER_LIMIT','PAYEE_ACCOUNT_NOT_EXSIT','PAYEE_USERINFO_STATUS_ERROR','TRUSTEESHIP_RECIEVE_QUOTA_LIMIT','EXCEED_LIMIT_UNRN_DM_AMOUNT','INVALID_CARDNO','RELEASE_USER_FORBBIDEN_RECIEVE','PAYEE_USER_TYPE_ERROR','PAYEE_NOT_RELNAME_CERTIFY','PERMIT_LIMIT_PAYEE',

		'OPENID_ERROR','NAME_MISMATCH','V2_ACCOUNT_SIMPLE_BAN','MONEY_LIMIT','EXCEED_PAYEE_ACCOUNT_LIMIT','PAYEE_ACCOUNT_ABNORMAL','APPID_OR_OPENID_ERR',

		'REALNAME_CHECK_ERROR','RE_USER_NAME_CHECK_ERROR','ERR_TJ_BLACK','USER_FROZEN','TRANSFER_FAIL','TRANSFER_FEE_LIMIT_ERROR',

		'ACCOUNT_FROZEN','REAL_NAME_CHECK_FAIL','NAME_NOT_CORRECT','OPENID_INVALID','TRANSFER_QUOTA_EXCEED','DAY_RECEIVED_QUOTA_EXCEED','MONTH_RECEIVED_QUOTA_EXCEED','DAY_RECEIVED_COUNT_EXCEED','ID_CARD_NOT_CORRECT','ACCOUNT_NOT_EXIST','TRANSFER_RISK','REALNAME_ACCOUNT_RECEIVED_QUOTA_EXCEED','RECEIVE_ACCOUNT_NOT_PERMMIT','PAYEE_ACCOUNT_ABNORMAL','BLOCK_B2C_USERLIMITAMOUNT_BSRULE_MONTH','BLOCK_B2C_USERLIMITAMOUNT_MONTH',
	];

	$money = $conf['auto_settle_money']; //商户超过此金额自动结算
	$success=0;
	$list = $DB->getAll("SELECT * FROM pre_user WHERE status=1 AND settle=1 AND settle_id=1 AND money>'$money' order by uid desc limit 5");
	foreach($list as $row){
		$settle_rate = $conf['settle_rate'];
		$group = getGroupConfig($row['gid']);
		if(isset($group['settle_open']) && $group['settle_open'] == 2) continue;
		if(isset($group['settle_rate']) && $group['settle_rate']!=='' && $group['settle_rate']!==null) $settle_rate = $group['settle_rate'];
		if($settle_rate>0){
			$fee=round($row['money']*$settle_rate/100,2);
			if(!empty($conf['settle_fee_max']) && $fee>$conf['settle_fee_max'])$fee=$conf['settle_fee_max'];
			$realmoney=$row['money']-$fee;
		}else{
			$realmoney=$row['money'];
		}
		$out_biz_no = date("YmdHis").rand(11111,99999);
		$channel = \lib\Channel::get($conf['transfer_alipay']);
		$result = transfer_do('alipay', $channel, $out_biz_no, $row['account'], $row['username'], $realmoney);
		if($result['code']==0){
			$data = ['uid'=>$row['uid'], 'type'=>$row['settle_id'], 'account'=>$row['account'], 'username'=>$row['username'], 'money'=>$row['money'], 'realmoney'=>$realmoney, 'addtime'=>'NOW()', 'endtime'=>'NOW()', 'status'=>1, 'transfer_no'=>$out_biz_no, 'transfer_channel'=>$conf['transfer_alipay'], 'transfer_status'=>1, 'transfer_result'=>$result["orderid"], 'transfer_date'=>$result["paydate"]];
			if($DB->insert('settle', $data)){
				$success++;
				changeUserMoney($row['uid'], $row['money'], false, '自动结算');
				echo '商户'.$row['uid'].'成功结算'.$realmoney.'元，交易号：'.$result["orderid"].'<br/>';
			}else{
				echo '商户'.$row['uid'].'成功结算'.$realmoney.'元，但记录插入失败<br/>';
			}
		}else{
			echo '商户'.$row['uid'].'结算'.$realmoney.'元失败：'.$result['msg'].'<br/>';
			if(!in_array($result['errcode'], $payee_err_code)){
				$DB->exec("UPDATE pre_channel SET status=0 WHERE id='{$channel['id']}'");
				echo '已关闭通道:'.$channel['name'].'<br/>';
				$mail_name = $conf['mail_recv']?$conf['mail_recv']:$conf['mail_name'];
				send_mail($mail_name,$conf['sitename'].' - 支付通道自动关闭提醒','尊敬的管理员：支付通道“'.$channel['name'].'”因自动结算转账失败，已被系统自动关闭！<br/>----------<br/>'.$conf['sitename'].'<br/>'.date('Y-m-d H:i:s'));
			}
		}
	}
	echo '成功结算'.$success.'个商户<br/>';
}