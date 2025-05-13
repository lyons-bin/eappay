<?php

namespace lib\ProfitSharing;

require_once PLUGIN_ROOT . 'adapay/inc/Build.class.php';

use Exception;

class Adapay implements IProfitSharing
{

    static $paytype = 'adapay';

    private $channel;
    private $service;

    function __construct($channel){
		$this->channel = $channel;
        $pay_config = require(PLUGIN_ROOT.$channel['plugin'].'/inc/config.php');
        $this->service = \AdaPay::config($pay_config);
	}

    //请求分账
    public function submit($trade_no, $api_trade_no, $account, $name, $money){
        global $DB;
        $order_money = $DB->findColumn('order', 'realmoney', ['trade_no'=>$trade_no]);

        if(strpos($account, '|')){
            $accounts = explode('|', $account);
            $psorder = CommUtil::getOrder($trade_no);
            $rates = explode('|', $psorder['rate']);
            $div_members = [];
            $allmoney = 0;
            foreach($accounts as $i=>$account){
                $rate = isset($rates[$i]) ? $rates[$i] : $rates[0];
                $money = round($order_money * $rate / 100, 2);
                $div_members[] = ['member_id'=>$account, 'amount' => sprintf('%.2f' , $money), 'fee_flag'=>$i==0?'Y':'N'];
                $allmoney += $money;
            }
            if($order_money > $allmoney){
                $psmoney2 = round($order_money-$allmoney, 2);
                $div_members[] = ['member_id'=>'0', 'amount' => sprintf('%.2f' , $psmoney2), 'fee_flag'=>'N'];
            }
        }else{
            $psmoney2 = round($order_money-$money, 2);
            $div_members = [];
            $div_members[] = ['member_id'=>$account, 'amount' => sprintf('%.2f' , $money), 'fee_flag'=>'Y'];
            if($psmoney2 > 0){
                $div_members[] = ['member_id'=>'0', 'amount' => sprintf('%.2f' , $psmoney2), 'fee_flag'=>'N'];
            }
        }
        $params = [
            'payment_id' => $api_trade_no,
            'order_no' => date("YmdHis").rand(11111,99999),
            'confirm_amt' => $order_money,
            'div_members' => $div_members,
        ];

        try{
            $result = $this->service->createPaymentConfirm($params);
            return ['code'=>1, 'msg'=>'分账成功', 'settle_no'=>$result['id']];
        } catch (Exception $e) {
            return ['code'=>-1, 'msg'=>$e->getMessage()];
        }
    }

    //查询分账结果
    public function query($trade_no, $api_trade_no, $settle_no){
        try{
            $result = $this->service->queryPaymentConfirm($settle_no);
            return ['code'=>0, 'status'=>1];
        } catch (Exception $e) {
            return ['code'=>-1, 'msg'=>$e->getMessage()];
        }
    }

    //解冻剩余资金
    public function unfreeeze($trade_no, $api_trade_no){
        global $DB;
        $order_money = $DB->findColumn('order', 'realmoney', ['trade_no'=>$trade_no]);
        $params = [
            'payment_id' => $api_trade_no,
            'order_no' => date("YmdHis").rand(11111,99999),
            'reverse_amt' => $order_money,
        ];

        try{
            $result = $this->service->createPaymentReverse($params);
            return ['code'=>0, 'msg'=>'解冻剩余资金成功', 'settle_no'=>$result['id']];
        } catch (Exception $e) {
            return ['code'=>-1, 'msg'=>$e->getMessage()];
        }
    }

    //分账回退
    public function return($trade_no, $api_trade_no, $account, $money){
        return ['code'=>-1,'msg'=>'不支持当前操作'];
    }

    //添加分账接收方
    public function addReceiver($account, $name = null){
        return ['code'=>0, 'msg'=>'添加分账接收方成功'];
    }

    //删除分账接收方
    public function deleteReceiver($account){
        return ['code'=>0, 'msg'=>'删除分账接收方成功'];
    }
}