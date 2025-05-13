CREATE TABLE IF NOT EXISTS `pre_suborder` (
  `sub_trade_no` varchar(25) NOT NULL,
  `trade_no` char(19) NOT NULL,
  `api_trade_no` varchar(150) DEFAULT NULL,
  `money` decimal(10,2) NOT NULL,
  `refundmoney` decimal(10,2) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `settle` tinyint(1) NOT NULL DEFAULT '0',
 PRIMARY KEY (`sub_trade_no`),
 KEY `trade_no` (`trade_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE `pre_order`
ADD COLUMN `bill_mch_trade_no` varchar(150) DEFAULT NULL,
ADD INDEX `bill_mch_trade_no` (`bill_mch_trade_no`);