<?php
include("../includes/common.php");
if($islogin==1){}else exit("<script language='javascript'>window.location.href='./login.php';</script>");
$act=isset($_GET['act'])?daddslashes($_GET['act']):null;

if(!checkRefererHost())exit('{"code":403}');

@header('Content-Type: application/json; charset=UTF-8');

switch($act){

case 'orderList':
	$sql=" 1=1";
	if(isset($_POST['rid']) && !empty($_POST['rid'])) {
		$rid = intval($_POST['rid']);
		$sql.=" AND A.`rid`='$rid'";
	}
	if(isset($_POST['dstatus']) && $_POST['dstatus']>-1) {
		$dstatus = intval($_POST['dstatus']);
		$sql.=" AND A.`status`={$dstatus}";
	}
	if(!empty($_POST['starttime']) || !empty($_POST['endtime'])){
		if(!empty($_POST['starttime'])){
			$starttime = daddslashes($_POST['starttime']);
			$sql.=" AND A.addtime>='{$starttime} 00:00:00'";
		}
		if(!empty($_POST['endtime'])){
			$endtime = daddslashes($_POST['endtime']);
			$sql.=" AND A.addtime<='{$endtime} 23:59:59'";
		}
	}
	if(isset($_POST['value']) && !empty($_POST['value'])) {
		$sql.=" AND A.`{$_POST['column']}`='{$_POST['value']}'";
	}
	$offset = intval($_POST['offset']);
	$limit = intval($_POST['limit']);
	$total = $DB->getColumn("SELECT count(*) from pre_psorder A LEFT JOIN pre_psreceiver B ON A.rid=B.id LEFT JOIN pre_channel C ON B.channel=C.id WHERE{$sql}");
	$list = $DB->getAll("SELECT A.*,C.id channelid,C.name channelname FROM pre_psorder A LEFT JOIN pre_psreceiver B ON A.rid=B.id LEFT JOIN pre_channel C ON B.channel=C.id WHERE{$sql} order by A.id desc limit $offset,$limit");

	exit(json_encode(['total'=>$total, 'rows'=>$list]));
break;

case 'get_receiver':
	$id=intval($_GET['id']);
	$row=$DB->find('psreceiver', '*', ['id'=>$id]);
	if(!$row) exit('{"code":-1,"msg":"当前分账规则不存在！"}');
	exit(json_encode(['code'=>0, 'data'=>$row]));
break;

case 'add_receiver':
	$data = [
		'channel' => intval($_POST['channel']),
		'uid' => !empty($_POST['uid'])?intval($_POST['uid']):null,
		'subchannel' => !empty($_POST['subchannel']) ? intval($_POST['subchannel']) : null,
		'account' => trim($_POST['account']),
		'name' => trim($_POST['name']),
		'rate' => !empty($_POST['rate'])?trim($_POST['rate']):'30',
		'minmoney' => trim($_POST['minmoney']),
		'status' => 0,
		'addtime' => 'NOW()'
	];
	if(!$data['channel'] || !$data['account'])exit('{"code":-1,"msg":"必填项不能为空"}');
	if(!empty($data['uid']) && !$DB->find('user', 'uid', ['uid'=>$data['uid']]))exit('{"code":-1,"msg":"商户ID不存在"}');
	if(!\lib\Channel::get($data['channel']))exit('{"code":-1,"msg":"支付通道不存在"}');
	if(!strpos($data['rate'], '|') && $data['rate'] > 100) exit('{"code":-1,"msg":"分账比例不能大于100"}');
	$rows = $DB->getRow("SELECT * FROM `pre_psreceiver` WHERE `channel`='{$data['channel']}' AND ".($data['uid']?"`uid`='{$data['uid']}'":"`uid` IS NULL")."");
	if($rows)exit('{"code":-1,"msg":"该支付通道&UID已存在分账规则，每次支付只能同时给1个人分账"}');
	if($DB->insert('psreceiver', $data)){
		exit('{"code":0,"msg":"新增分账规则成功！"}');
	}else{
		exit('{"code":-1,"msg":"新增分账规则失败['.$DB->error().']"}');
	}
break;

case 'edit_receiver':
	$id=intval($_POST['id']);
	$row=$DB->find('psreceiver', '*', ['id'=>$id]);
	if(!$row) exit('{"code":-1,"msg":"当前分账规则不存在！"}');
	$data = [
		'channel' => intval($_POST['channel']),
		'uid' => !empty($_POST['uid'])?intval($_POST['uid']):null,
		'subchannel' => !empty($_POST['subchannel']) ? intval($_POST['subchannel']) : null,
		'account' => trim($_POST['account']),
		'name' => trim($_POST['name']),
		'rate' => !empty($_POST['rate'])?trim($_POST['rate']):30,
		'minmoney' => trim($_POST['minmoney']),
	];
	if(!$data['channel'] || !$data['account'])exit('{"code":-1,"msg":"必填项不能为空"}');
	if(!empty($data['uid']) && !$DB->find('user', 'uid', ['uid'=>$data['uid']]))exit('{"code":-1,"msg":"商户ID不存在"}');
	if(!\lib\Channel::get($data['channel']))exit('{"code":-1,"msg":"支付通道不存在"}');
	if(!strpos($data['rate'], '|') && $data['rate'] > 100) exit('{"code":-1,"msg":"分账比例不能大于100"}');
	$rows = $DB->getRow("SELECT * FROM `pre_psreceiver` WHERE `channel`='{$data['channel']}' AND ".($data['uid']?"`uid`='{$data['uid']}'":"`uid` IS NULL")." AND id!='$id'");
	if($rows)exit('{"code":-1,"msg":"该支付通道&UID已存在分账规则，每次支付只能同时给1个人分账"}');
	if($row['status']==1 && $data['channel'] != $row['channel']){
		exit('{"code":-1,"msg":"请先将状态改为已关闭再切换通道"}');
	}
	if($row['status']==1 && ($data['account']!=$row['account'] || $data['name']!=$row['name'] || $data['channel']!=$row['channel'])){
		$channel = $row['subchannel'] > 0 ? \lib\Channel::getSub($row['subchannel']) : \lib\Channel::get($row['channel'], $row['uid']?$DB->findColumn('user', 'channelinfo', ['uid'=>$row['uid']]):null);
		if($channel){
			$model = \lib\ProfitSharing\CommUtil::getModel($channel);
			$model->deleteReceiver($row['account'], $row['name']);
			$result = $model->addReceiver($data['account'], $data['name']);
			if($result['code'] != 0) exit(json_encode($result));
		}
	}
	if($DB->update('psreceiver', $data, ['id'=>$id])!==false){
		exit('{"code":0,"msg":"修改分账规则成功！"}');
	}else{
		exit('{"code":-1,"msg":"修改分账规则失败['.$DB->error().']"}');
	}
break;

case 'set_receiver':
	$id=intval($_POST['id']);
	$status=intval($_POST['status']);
	$row=$DB->find('psreceiver', '*', ['id'=>$id]);
	if(!$row) exit('{"code":-1,"msg":"当前分账规则不存在！"}');
	$channel = $row['subchannel'] > 0 ? \lib\Channel::getSub($row['subchannel']) : \lib\Channel::get($row['channel'], $row['uid']?$DB->findColumn('user', 'channelinfo', ['uid'=>$row['uid']]):null);
	if(!$channel) exit('{"code":-1,"msg":"当前支付通道不存在！"}');
	$model = \lib\ProfitSharing\CommUtil::getModel($channel);
	if($status == 1){
		$result = $model->addReceiver($row['account'], $row['name']);
	}elseif($status == 0){
		$result = $model->deleteReceiver($row['account'], $row['name']);
	}
	if($result['code'] == 0 || $status == 0 && strpos($result['msg'],'分账接收方不存在')!==false){
		$DB->update('psreceiver', ['status'=>$status], ['id'=>$id]);
		exit('{"code":0,"msg":"状态修改成功！"}');
	}else{
		exit(json_encode($result));
	}
break;

case 'del_receiver':
	$id=intval($_POST['id']);
	$row=$DB->find('psreceiver', '*', ['id'=>$id]);
	if(!$row) exit('{"code":-1,"msg":"当前分账规则不存在！"}');
	if($row['status']==1){
		$channel = $row['subchannel'] > 0 ? \lib\Channel::getSub($row['subchannel']) : \lib\Channel::get($row['channel'], $row['uid']?$DB->findColumn('user', 'channelinfo', ['uid'=>$row['uid']]):null);
		if($channel){
			$model = \lib\ProfitSharing\CommUtil::getModel($channel);
			$model->deleteReceiver($row['account'], $row['name']);
		}
	}
	if($DB->delete('psreceiver', ['id'=>$id])){
		exit('{"code":0,"msg":"删除分账规则成功！"}');
	}else{
		exit('{"code":-1,"msg":"删除分账规则失败['.$DB->error().']"}');
	}
break;


case 'submit':
	$id=intval($_POST['id']);
	$row = $DB->getRow("SELECT A.*,B.channel,B.account,B.name,B.uid psuid,C.uid,C.subchannel FROM pre_psorder A LEFT JOIN pre_psreceiver B ON A.rid=B.id LEFT JOIN pre_order C ON C.trade_no=A.trade_no WHERE A.id=:id", [':id'=>$id]);
	if(!$row)exit('{"code":-1,"msg":"订单不存在"}');
	if($row['status']!=0&&$row['status']!=3)exit('{"code":-1,"msg":"只有待分账的订单才能提交分账"}');
	$channel = $row['subchannel'] > 0 ? \lib\Channel::getSub($row['subchannel']) : \lib\Channel::get($row['channel'], $row['uid']?$DB->findColumn('user', 'channelinfo', ['uid'=>$row['uid']]):null);
	if(!$channel) exit('{"code":-1,"msg":"通道信息不存在"}');
	$model = \lib\ProfitSharing\CommUtil::getModel($channel);
	$result = $model->submit($row['trade_no'], $row['api_trade_no'], $row['account'], $row['name'], $row['money']);
	if($result['code'] == 0){
		$DB->update('psorder', ['status'=>1,'settle_no'=>$result['settle_no']], ['id'=>$id]);
	}elseif($result['code'] == 1){
		$DB->update('psorder', ['status'=>2,'settle_no'=>$result['settle_no']], ['id'=>$id]);
		if(!empty($row['psuid']) && $channel['mode']==0){
			changeUserMoney($row['psuid'], $row['money'], false, '订单分账', $row['trade_no']);
		}
	}elseif($result['code'] == -2){
		//$DB->update('psorder', ['status'=>3,'result'=>$result['msg']], ['id'=>$id]);
	}
	exit(json_encode($result));
break;

case 'query':
	$id=intval($_POST['id']);
	$row = $DB->getRow("SELECT A.*,B.channel,B.account,B.name,B.uid psuid,C.uid,C.subchannel FROM pre_psorder A LEFT JOIN pre_psreceiver B ON A.rid=B.id LEFT JOIN pre_order C ON C.trade_no=A.trade_no WHERE A.id=:id", [':id'=>$id]);
	if(!$row)exit('{"code":-1,"msg":"订单不存在"}');
	if($row['status']!=1)exit('{"code":-1,"msg":"只有已提交的订单才能查询结果"}');
	$channel = $row['subchannel'] > 0 ? \lib\Channel::getSub($row['subchannel']) : \lib\Channel::get($row['channel'], $row['uid']?$DB->findColumn('user', 'channelinfo', ['uid'=>$row['uid']]):null);
	if(!$channel) exit('{"code":-1,"msg":"通道信息不存在"}');
	$model = \lib\ProfitSharing\CommUtil::getModel($channel);
	$result = $model->query($row['trade_no'], $row['api_trade_no'], $row['settle_no']);
	if($result['code']==0){
		if($result['status']==1){
			$DB->update('psorder', ['status'=>2], ['id'=>$id]);
			if(!empty($row['psuid']) && $channel['mode']==0){
				changeUserMoney($row['psuid'], $row['money'], false, '订单分账', $row['trade_no']);
			}
		}elseif($result['status']==2){
			$DB->update('psorder', ['status'=>3,'result'=>$result['reason']], ['id'=>$id]);
		}
	}
	exit(json_encode($result));
break;

case 'unfreeeze':
	$id=intval($_POST['id']);
	$row = $DB->getRow("SELECT A.*,B.channel,B.account,B.name,C.uid,C.subchannel FROM pre_psorder A LEFT JOIN pre_psreceiver B ON A.rid=B.id LEFT JOIN pre_order C ON C.trade_no=A.trade_no WHERE A.id=:id", [':id'=>$id]);
	if(!$row)exit('{"code":-1,"msg":"订单不存在"}');
	if($row['status']==2)exit('{"code":-1,"msg":"只有待分账的订单才能取消分账"}');
	$channel = $row['subchannel'] > 0 ? \lib\Channel::getSub($row['subchannel']) : \lib\Channel::get($row['channel'], $row['uid']?$DB->findColumn('user', 'channelinfo', ['uid'=>$row['uid']]):null);
	if(!$channel) exit('{"code":-1,"msg":"通道信息不存在"}');
	$model = \lib\ProfitSharing\CommUtil::getModel($channel);
	$result = $model->unfreeeze($row['trade_no'], $row['api_trade_no']);
	if($result['code'] == 0){
		$DB->update('psorder', ['status'=>4], ['id'=>$id]);
	}
	exit(json_encode($result));
break;

case 'return':
	$id=intval($_POST['id']);
	$row = $DB->getRow("SELECT A.*,B.channel,B.account,B.name,C.uid,C.subchannel FROM pre_psorder A LEFT JOIN pre_psreceiver B ON A.rid=B.id LEFT JOIN pre_order C ON C.trade_no=A.trade_no WHERE A.id=:id", [':id'=>$id]);
	if(!$row)exit('{"code":-1,"msg":"订单不存在"}');
	if($row['status']!=2)exit('{"code":-1,"msg":"只有分账成功的订单才能回退"}');
	$channel = $row['subchannel'] > 0 ? \lib\Channel::getSub($row['subchannel']) : \lib\Channel::get($row['channel'], $row['uid']?$DB->findColumn('user', 'channelinfo', ['uid'=>$row['uid']]):null);
	if(!$channel) exit('{"code":-1,"msg":"通道信息不存在"}');
	$model = \lib\ProfitSharing\CommUtil::getModel($channel);
	$result = $model->return($row['trade_no'], $row['api_trade_no'], $row['account'], $row['money']);
	if($result['code'] == 0){
		$DB->update('psorder', ['status'=>4], ['id'=>$id]);
	}
	exit(json_encode($result));
break;

case 'editmoney':
	$id=intval($_POST['id']);
	$money=trim($_POST['money']);
	if(!is_numeric($money) || !preg_match('/^[0-9.]+$/', $money))exit('{"code":-1,"msg":"金额输入错误"}');
	$row = $DB->getRow("SELECT * FROM pre_psorder WHERE id=:id", [':id'=>$id]);
	if(!$row)exit('{"code":-1,"msg":"订单不存在"}');
	if($row['status']!=0)exit('{"code":-1,"msg":"只有待分账的订单才能修改金额"}');
	$DB->update('psorder', ['money'=>$money], ['id'=>$id]);
	exit('{"code":0,"msg":"succ"}');
break;

case 'operation': //批量操作订单
	$status=is_numeric($_POST['status'])?intval($_POST['status']):exit('{"code":-1,"msg":"请选择操作"}');
	$checkbox=$_POST['checkbox'];
	$i=0;
	foreach($checkbox as $id){
		if($status==5)$DB->exec("DELETE FROM pre_psorder WHERE id='$id'");
		else $DB->exec("update pre_psorder set status='$status' where id='$id' limit 1");
		$i++;
	}
	exit('{"code":0,"msg":"成功改变'.$i.'条订单状态"}');
break;

case 'statistics':
    $sql = " 1=1";
    if(isset($_POST['rid']) && !empty($_POST['rid'])) {
        $rid = intval($_POST['rid']);
        $sql .= " AND rid='$rid'";
    }
    if(isset($_POST['dstatus']) && $_POST['dstatus']>-1) {
        $dstatus = intval($_POST['dstatus']);
        $sql .= " AND status={$dstatus}";
    }
    if(!empty($_POST['starttime']) || !empty($_POST['endtime'])){
        if(!empty($_POST['starttime'])){
            $starttime = daddslashes($_POST['starttime']);
            $sql .= " AND addtime>='{$starttime} 00:00:00'";
        }
        if(!empty($_POST['endtime'])){
            $endtime = daddslashes($_POST['endtime']);
            $sql .= " AND addtime<='{$endtime} 23:59:59'";
        }
    }
    if(isset($_POST['value']) && !empty($_POST['value'])) {
        $column = daddslashes($_POST['column']);
        if($column == 'money'){
            $sql .= " AND {$column}='".floatval($_POST['value'])."'";
        }else{
            $sql .= " AND {$column}='".daddslashes($_POST['value'])."'";
        }
    }

    $result = $DB->getRow("SELECT 
        SUM(money) AS totalMoney,
        SUM(CASE WHEN status = 2 THEN money ELSE 0 END) AS successMoney,
        SUM(CASE WHEN status = 3 THEN money ELSE 0 END) AS failMoney,
        COUNT(*) AS totalCount,
        SUM(CASE WHEN status = 2 THEN 1 ELSE 0 END) AS successCount,
        SUM(CASE WHEN status = 3 THEN 1 ELSE 0 END) AS failCount
        FROM pre_psorder WHERE {$sql}");

    $successRate = $result['totalCount'] > 0 ? round(($result['successCount'] / $result['totalCount']) * 100, 2) : 0;

    $data = [
        'totalMoney' => number_format($result['totalMoney'] ?? 0, 2, '.', ''),
        'successMoney' => number_format($result['successMoney'] ?? 0, 2, '.', ''),
        'failMoney' => number_format($result['failMoney'] ?? 0, 2, '.', ''),
        'totalCount' => $result['totalCount'] ?? 0,
        'successCount' => $result['successCount'] ?? 0,
        'failCount' => $result['failCount'] ?? 0,
        'successRate' => $successRate
    ];
    
    exit(json_encode(['code' => 0, 'data' => $data]));
break;

default:
	exit('{"code":-4,"msg":"No Act"}');
break;
}