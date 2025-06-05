

-- ----------------------------
-- Table structure for pay_anounce
-- ----------------------------
DROP TABLE IF EXISTS `pay_anounce`;
CREATE TABLE `pay_anounce`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `color` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sort` int(11) NOT NULL DEFAULT 1,
  `addtime` datetime NULL DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pay_anounce
-- ----------------------------

-- ----------------------------
-- Table structure for pay_batch
-- ----------------------------
DROP TABLE IF EXISTS `pay_batch`;
CREATE TABLE `pay_batch`  (
  `batch` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `allmoney` decimal(10, 2) NOT NULL,
  `count` int(11) NOT NULL DEFAULT 0,
  `time` datetime NULL DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`batch`) USING BTREE
);

-- ----------------------------
-- Records of pay_batch
-- ----------------------------

-- ----------------------------
-- Table structure for pay_blacklist
-- ----------------------------
DROP TABLE IF EXISTS `pay_blacklist`;
CREATE TABLE `pay_blacklist`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` tinyint(1) NOT NULL DEFAULT 0,
  `content` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `addtime` datetime NOT NULL,
  `endtime` datetime NULL DEFAULT NULL,
  `remark` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `content`(`content`, `type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pay_blacklist
-- ----------------------------

-- ----------------------------
-- Table structure for pay_cache
-- ----------------------------
DROP TABLE IF EXISTS `pay_cache`;
CREATE TABLE `pay_cache`  (
  `k` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `v` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `expire` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`k`) USING BTREE
);

-- ----------------------------
-- Records of pay_cache
-- ----------------------------
INSERT INTO `pay_cache` VALUES ('config', 'a:64:{s:12:\"admin_paypwd\";s:6:\"123456\";s:9:\"admin_pwd\";s:10:\"Zxczxc@321\";s:10:\"admin_user\";s:5:\"admin\";s:10:\"blockalert\";s:72:\"温馨提醒该商品禁止出售，如有疑问请联系网站客服！\";s:9:\"blockname\";s:0:\"\";s:5:\"build\";s:10:\"2025-05-13\";s:10:\"captcha_id\";s:0:\"\";s:11:\"captcha_key\";s:0:\"\";s:12:\"captcha_open\";s:1:\"1\";s:9:\"cdnpublic\";s:1:\"4\";s:7:\"cronkey\";s:6:\"993440\";s:11:\"description\";s:239:\"聚合支付是XX公司旗下的免签约支付产品，完美解决支付难题，一站式接入支付宝，微信，财付通，QQ钱包,微信wap，帮助开发者快速集成到自己相应产品，效率高，见效快，费率低！\";s:8:\"homepage\";s:1:\"0\";s:7:\"ip_type\";s:1:\"2\";s:8:\"keywords\";s:118:\"聚合支付,支付宝免签约即时到账,财付通免签约,微信免签约支付,QQ钱包免签约,免签约支付\";s:4:\"kfqq\";s:9:\"123456789\";s:12:\"login_alipay\";s:1:\"0\";s:20:\"login_alipay_channel\";s:1:\"0\";s:8:\"login_qq\";s:1:\"0\";s:8:\"login_wx\";s:1:\"0\";s:16:\"login_wx_channel\";s:1:\"0\";s:10:\"mail_cloud\";s:1:\"0\";s:9:\"mail_name\";s:0:\"\";s:9:\"mail_port\";s:3:\"465\";s:8:\"mail_pwd\";s:0:\"\";s:9:\"mail_smtp\";s:11:\"smtp.qq.com\";s:15:\"notifyordername\";s:1:\"1\";s:7:\"onecode\";s:1:\"1\";s:7:\"orgname\";s:8:\"XX公司\";s:13:\"pageordername\";s:1:\"1\";s:12:\"pay_maxmoney\";s:4:\"1000\";s:11:\"private_key\";s:1624:\"MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCyvnIeEYTuYvMvixTfy0Y4bl6PIjnr/1TPnBjcUedahKldzMTK4/ku0N3VMQ3HBxF6T/jxKPJtWKje02nLtXQvUQfRCcQE0hCMESnCxiE1aZGmE27Rk0AtwNCu0wxkiMTOJ+IHPMQacxT5uzj+rTN55vndPB8vxyCGBuxTTTGA1oq/c4UXTuA4oeffCmQbv2GPZGATO96tR54ufRZMM4QVxF4efGxWVO1U0Urb9X8tjRWudFa+NwD1TdDicVBYeKw/xDwd+sbkfNgXSnSsGF07SthUYU0J07jZcNFvCYrt3Uen4XMffe60pfvGKHkkPHvvmf5aSxlM5oYi8r7qJFmHAgMBAAECggEAc0Oop4c4p9mbZO9VeLPHBqD1zWuO2ob/FBpfVcRjYtXluh1QUl4M1InQY6iMb+o49R0ZNbroCmeADqFaugi7cb/ZQI4Bn/IuxYRT38yQobcAO46Qiglg+6A5cmOavEIOV7sUYQJom33W6uw25tSeO2AdhPM+UTsh2Awi3d0LrT6Yt6E/9Fux58nqz2yAGO+oP0If25gZJ6yLWAogkEM1LQShVIFsOREeEt7T9SxyeJvJ72DY72FEOH4FifS4KznAuNlSNcoGdW/oyM0XFtdNBjm2pLrLz/P0o8emee+3sb78F/dfKxeNn5xMZ7tB+w9+BoOnwCcTFVe1kXaKO+Aa0QKBgQDX/IySm1U+X34W8NSd74kB49lhoRj6Yd08aac260snYt2miLtbvHorRgUEkFBnHu9nbfej70EFkO1YQU9N+5+DOgmZ7mv2OF1+WfYond9igTrQG1Ur2d9KAna4FXt1ifQAzfbdXKHlSs4pzrIax+5M0IVTVGQ1cAXJ9oz9a7CtvQKBgQDT253ifrcYd+UIeB4/95xpDbhI596CvyzeTnneTEcB0tZZCIzn4T1RZsJAJB+mhZ56Gi/pjecSK2k+AWunq72yMh4mqukOumdZGvQ6ATiOYtfNNV4rIQ4Nac7MftG8Q6IN4ZacGC4u/7qlvCZdD/XiUzNzTsrTEat48NPuO1VOkwKBgElmil9Iaq/HxBIHxjnmLal2xWloVhTBLW5aeXkwfVnlP25ZCVMjumD6aroiUTC6UqHTvVT4+h/qIL7dcxYNbSgrkRe+7vG+Nge6iu1CuafAQzx2DXvZjwiXzcDBjDNlroaXeE3CLUK/KVEL7Xssds+kDatEAsomR9Fa+I8nCeQBAoGAUv+IBDLWclyOOtosJ61O9o0sdEt6jchtwI4ICoHhk6JQ3UKPSUyhpCFY2p4MVEWmx3k46gvwydp9+Y++6EpNH+GolEeC1IVMdcksgwj1ajrpBnjw8n6ZrcGVBeJtMo9gjoWhZnfGqB0Bt2pVsUHOd6NW1ca5iSU0A0Z+EKfoDMcCgYEAlpTpt2KL7BeRsyvWv6T2eNT3W6LOCEt/m8gaM0XPnZtcOTMn/mb+7ucaUicwPNhkoVwxk30pZlC76kJWRA6YV+8hEsSm1X92aYSjabIiFepIre2cFsA4SiL7ZYn01l5ciT9znLR+N207HIpWFyUomgjSxT99cawF9oF6sPFlZR8=\";s:10:\"public_key\";s:392:\"MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAsr5yHhGE7mLzL4sU38tGOG5ejyI56/9Uz5wY3FHnWoSpXczEyuP5LtDd1TENxwcRek/48SjybVio3tNpy7V0L1EH0QnEBNIQjBEpwsYhNWmRphNu0ZNALcDQrtMMZIjEzifiBzzEGnMU+bs4/q0zeeb53TwfL8cghgbsU00xgNaKv3OFF07gOKHn3wpkG79hj2RgEzverUeeLn0WTDOEFcReHnxsVlTtVNFK2/V/LY0VrnRWvjcA9U3Q4nFQWHisP8Q8HfrG5HzYF0p0rBhdO0rYVGFNCdO42XDRbwmK7d1Hp+FzH33utKX7xih5JDx775n+WksZTOaGIvK+6iRZhwIDAQAB\";s:8:\"recharge\";s:1:\"1\";s:8:\"reg_open\";s:1:\"1\";s:7:\"reg_pay\";s:1:\"1\";s:13:\"reg_pay_price\";s:1:\"5\";s:11:\"reg_pay_uid\";s:4:\"1000\";s:13:\"settle_alipay\";s:1:\"1\";s:11:\"settle_bank\";s:1:\"0\";s:14:\"settle_fee_max\";s:2:\"20\";s:14:\"settle_fee_min\";s:3:\"0.1\";s:12:\"settle_money\";s:2:\"30\";s:11:\"settle_open\";s:1:\"1\";s:12:\"settle_qqpay\";s:1:\"1\";s:11:\"settle_rate\";s:3:\"0.5\";s:11:\"settle_type\";s:1:\"1\";s:12:\"settle_wxpay\";s:1:\"1\";s:8:\"sitename\";s:18:\"聚合支付平台\";s:7:\"sms_api\";s:1:\"0\";s:6:\"syskey\";s:32:\"S6CsGxCa66Us46gAj7zuEeK6K67k4A4G\";s:8:\"template\";s:6:\"index1\";s:9:\"test_open\";s:1:\"1\";s:12:\"test_pay_uid\";s:4:\"1000\";s:5:\"title\";s:51:\"聚合支付 - 行业领先的免签约支付平台\";s:16:\"tongji_cachetime\";s:10:\"1747142088\";s:15:\"transfer_alipay\";s:1:\"0\";s:13:\"transfer_desc\";s:30:\"聚合支付平台自动结算\";s:13:\"transfer_name\";s:18:\"聚合支付平台\";s:14:\"transfer_qqpay\";s:1:\"0\";s:14:\"transfer_wxpay\";s:1:\"0\";s:11:\"user_refund\";s:1:\"1\";s:10:\"verifytype\";s:1:\"1\";s:7:\"version\";s:4:\"2046\";}', 0);
INSERT INTO `pay_cache` VALUES ('tongji', 'a:3:{s:9:\"usermoney\";N;s:11:\"settlemoney\";N;s:11:\"order_today\";a:5:{s:3:\"all\";d:0;s:10:\"profit_all\";d:0;s:7:\"paytype\";a:3:{i:1;d:0;i:2;d:0;i:3;d:0;}s:7:\"channel\";N;s:14:\"profit_paytype\";a:3:{i:1;d:0;i:2;d:0;i:3;d:0;}}}', 0);

-- ----------------------------
-- Table structure for pay_channel
-- ----------------------------
DROP TABLE IF EXISTS `pay_channel`;
CREATE TABLE `pay_channel`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `mode` tinyint(1) NULL DEFAULT 0,
  `type` int(11) UNSIGNED NOT NULL,
  `plugin` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `rate` decimal(5, 2) NOT NULL DEFAULT 100.00,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `apptype` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `daytop` int(10) NULL DEFAULT 0,
  `daystatus` tinyint(1) NULL DEFAULT 0,
  `paymin` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `paymax` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `appwxmp` int(11) NULL DEFAULT NULL,
  `appwxa` int(11) NULL DEFAULT NULL,
  `costrate` decimal(5, 2) NULL DEFAULT NULL,
  `config` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `type`(`type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pay_channel
-- ----------------------------
INSERT INTO `pay_channel` VALUES (1, 0, 1, 'epay', 'TM3', 94.00, 0, NULL, 0, 0, '', '', NULL, NULL, 5.00, '{\"appurl\":\"https:\\/\\/api3.yktzo.cn\\/\",\"appid\":\"1743736653655965793\",\"appkey\":\"e01e6705fc5c489e9332ca1b4dcb23c7TAXJRc\",\"appswitch\":\"1\"}');
INSERT INTO `pay_channel` VALUES (2, 0, 1, 'epay', '369-zfb', 94.00, 1, NULL, 0, 0, '', '', NULL, NULL, 5.00, '{\"appurl\":\"https:\\/\\/zf11.wew.qkpdk.cn\\/\",\"appid\":\"1050\",\"appkey\":\"4ReJTyxDFxQ8N8XrRM5dt5PJdP0uf81q\",\"appswitch\":\"1\"}');
INSERT INTO `pay_channel` VALUES (4, 0, 1, 'epay', '圆圆支付-ZFB', 94.00, 1, NULL, 0, 0, '', '', NULL, NULL, 5.00, '{\"appurl\":\"https:\\/\\/api4.yktzo.cn\\/\",\"appid\":\"1747144417031492015\",\"appkey\":\"344e399b76334775a492dfc2071ee07fHBFpsz\",\"appswitch\":\"1\"}');

-- ----------------------------
-- Table structure for pay_config
-- ----------------------------
DROP TABLE IF EXISTS `pay_config`;
CREATE TABLE `pay_config`  (
  `k` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `v` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`k`) USING BTREE
);

-- ----------------------------
-- Records of pay_config
-- ----------------------------
INSERT INTO `pay_config` VALUES ('admin_paypwd', '123456');
INSERT INTO `pay_config` VALUES ('admin_pwd', 'Zxczxc@321');
INSERT INTO `pay_config` VALUES ('admin_user', 'admin');
INSERT INTO `pay_config` VALUES ('blockalert', '温馨提醒该商品禁止出售，如有疑问请联系网站客服！');
INSERT INTO `pay_config` VALUES ('blockname', '');
INSERT INTO `pay_config` VALUES ('build', '2025-05-13');
INSERT INTO `pay_config` VALUES ('captcha_id', '');
INSERT INTO `pay_config` VALUES ('captcha_key', '');
INSERT INTO `pay_config` VALUES ('captcha_open', '1');
INSERT INTO `pay_config` VALUES ('cdnpublic', '4');
INSERT INTO `pay_config` VALUES ('cronkey', '993440');
INSERT INTO `pay_config` VALUES ('description', '聚合支付是XX公司旗下的免签约支付产品，完美解决支付难题，一站式接入支付宝，微信，财付通，QQ钱包,微信wap，帮助开发者快速集成到自己相应产品，效率高，见效快，费率低！');
INSERT INTO `pay_config` VALUES ('homepage', '0');
INSERT INTO `pay_config` VALUES ('ip_type', '2');
INSERT INTO `pay_config` VALUES ('keywords', '聚合支付,支付宝免签约即时到账,财付通免签约,微信免签约支付,QQ钱包免签约,免签约支付');
INSERT INTO `pay_config` VALUES ('kfqq', '123456789');
INSERT INTO `pay_config` VALUES ('login_alipay', '0');
INSERT INTO `pay_config` VALUES ('login_alipay_channel', '0');
INSERT INTO `pay_config` VALUES ('login_qq', '0');
INSERT INTO `pay_config` VALUES ('login_wx', '0');
INSERT INTO `pay_config` VALUES ('login_wx_channel', '0');
INSERT INTO `pay_config` VALUES ('mail_cloud', '0');
INSERT INTO `pay_config` VALUES ('mail_name', '');
INSERT INTO `pay_config` VALUES ('mail_port', '465');
INSERT INTO `pay_config` VALUES ('mail_pwd', '');
INSERT INTO `pay_config` VALUES ('mail_smtp', 'smtp.qq.com');
INSERT INTO `pay_config` VALUES ('notifyordername', '1');
INSERT INTO `pay_config` VALUES ('onecode', '1');
INSERT INTO `pay_config` VALUES ('orgname', 'XX公司');
INSERT INTO `pay_config` VALUES ('pageordername', '1');
INSERT INTO `pay_config` VALUES ('pay_maxmoney', '1000');
INSERT INTO `pay_config` VALUES ('private_key', 'MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCyvnIeEYTuYvMvixTfy0Y4bl6PIjnr/1TPnBjcUedahKldzMTK4/ku0N3VMQ3HBxF6T/jxKPJtWKje02nLtXQvUQfRCcQE0hCMESnCxiE1aZGmE27Rk0AtwNCu0wxkiMTOJ+IHPMQacxT5uzj+rTN55vndPB8vxyCGBuxTTTGA1oq/c4UXTuA4oeffCmQbv2GPZGATO96tR54ufRZMM4QVxF4efGxWVO1U0Urb9X8tjRWudFa+NwD1TdDicVBYeKw/xDwd+sbkfNgXSnSsGF07SthUYU0J07jZcNFvCYrt3Uen4XMffe60pfvGKHkkPHvvmf5aSxlM5oYi8r7qJFmHAgMBAAECggEAc0Oop4c4p9mbZO9VeLPHBqD1zWuO2ob/FBpfVcRjYtXluh1QUl4M1InQY6iMb+o49R0ZNbroCmeADqFaugi7cb/ZQI4Bn/IuxYRT38yQobcAO46Qiglg+6A5cmOavEIOV7sUYQJom33W6uw25tSeO2AdhPM+UTsh2Awi3d0LrT6Yt6E/9Fux58nqz2yAGO+oP0If25gZJ6yLWAogkEM1LQShVIFsOREeEt7T9SxyeJvJ72DY72FEOH4FifS4KznAuNlSNcoGdW/oyM0XFtdNBjm2pLrLz/P0o8emee+3sb78F/dfKxeNn5xMZ7tB+w9+BoOnwCcTFVe1kXaKO+Aa0QKBgQDX/IySm1U+X34W8NSd74kB49lhoRj6Yd08aac260snYt2miLtbvHorRgUEkFBnHu9nbfej70EFkO1YQU9N+5+DOgmZ7mv2OF1+WfYond9igTrQG1Ur2d9KAna4FXt1ifQAzfbdXKHlSs4pzrIax+5M0IVTVGQ1cAXJ9oz9a7CtvQKBgQDT253ifrcYd+UIeB4/95xpDbhI596CvyzeTnneTEcB0tZZCIzn4T1RZsJAJB+mhZ56Gi/pjecSK2k+AWunq72yMh4mqukOumdZGvQ6ATiOYtfNNV4rIQ4Nac7MftG8Q6IN4ZacGC4u/7qlvCZdD/XiUzNzTsrTEat48NPuO1VOkwKBgElmil9Iaq/HxBIHxjnmLal2xWloVhTBLW5aeXkwfVnlP25ZCVMjumD6aroiUTC6UqHTvVT4+h/qIL7dcxYNbSgrkRe+7vG+Nge6iu1CuafAQzx2DXvZjwiXzcDBjDNlroaXeE3CLUK/KVEL7Xssds+kDatEAsomR9Fa+I8nCeQBAoGAUv+IBDLWclyOOtosJ61O9o0sdEt6jchtwI4ICoHhk6JQ3UKPSUyhpCFY2p4MVEWmx3k46gvwydp9+Y++6EpNH+GolEeC1IVMdcksgwj1ajrpBnjw8n6ZrcGVBeJtMo9gjoWhZnfGqB0Bt2pVsUHOd6NW1ca5iSU0A0Z+EKfoDMcCgYEAlpTpt2KL7BeRsyvWv6T2eNT3W6LOCEt/m8gaM0XPnZtcOTMn/mb+7ucaUicwPNhkoVwxk30pZlC76kJWRA6YV+8hEsSm1X92aYSjabIiFepIre2cFsA4SiL7ZYn01l5ciT9znLR+N207HIpWFyUomgjSxT99cawF9oF6sPFlZR8=');
INSERT INTO `pay_config` VALUES ('public_key', 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAsr5yHhGE7mLzL4sU38tGOG5ejyI56/9Uz5wY3FHnWoSpXczEyuP5LtDd1TENxwcRek/48SjybVio3tNpy7V0L1EH0QnEBNIQjBEpwsYhNWmRphNu0ZNALcDQrtMMZIjEzifiBzzEGnMU+bs4/q0zeeb53TwfL8cghgbsU00xgNaKv3OFF07gOKHn3wpkG79hj2RgEzverUeeLn0WTDOEFcReHnxsVlTtVNFK2/V/LY0VrnRWvjcA9U3Q4nFQWHisP8Q8HfrG5HzYF0p0rBhdO0rYVGFNCdO42XDRbwmK7d1Hp+FzH33utKX7xih5JDx775n+WksZTOaGIvK+6iRZhwIDAQAB');
INSERT INTO `pay_config` VALUES ('recharge', '1');
INSERT INTO `pay_config` VALUES ('reg_open', '1');
INSERT INTO `pay_config` VALUES ('reg_pay', '1');
INSERT INTO `pay_config` VALUES ('reg_pay_price', '5');
INSERT INTO `pay_config` VALUES ('reg_pay_uid', '1000');
INSERT INTO `pay_config` VALUES ('settle_alipay', '1');
INSERT INTO `pay_config` VALUES ('settle_bank', '0');
INSERT INTO `pay_config` VALUES ('settle_fee_max', '20');
INSERT INTO `pay_config` VALUES ('settle_fee_min', '0.1');
INSERT INTO `pay_config` VALUES ('settle_money', '30');
INSERT INTO `pay_config` VALUES ('settle_open', '1');
INSERT INTO `pay_config` VALUES ('settle_qqpay', '1');
INSERT INTO `pay_config` VALUES ('settle_rate', '0.5');
INSERT INTO `pay_config` VALUES ('settle_type', '1');
INSERT INTO `pay_config` VALUES ('settle_wxpay', '1');
INSERT INTO `pay_config` VALUES ('sitename', '聚合支付平台');
INSERT INTO `pay_config` VALUES ('sms_api', '0');
INSERT INTO `pay_config` VALUES ('syskey', 'S6CsGxCa66Us46gAj7zuEeK6K67k4A4G');
INSERT INTO `pay_config` VALUES ('template', 'index1');
INSERT INTO `pay_config` VALUES ('test_open', '1');
INSERT INTO `pay_config` VALUES ('test_pay_uid', '1000');
INSERT INTO `pay_config` VALUES ('title', '聚合支付 - 行业领先的免签约支付平台');
INSERT INTO `pay_config` VALUES ('tongji_cachetime', '1747142088');
INSERT INTO `pay_config` VALUES ('transfer_alipay', '0');
INSERT INTO `pay_config` VALUES ('transfer_desc', '聚合支付平台自动结算');
INSERT INTO `pay_config` VALUES ('transfer_name', '聚合支付平台');
INSERT INTO `pay_config` VALUES ('transfer_qqpay', '0');
INSERT INTO `pay_config` VALUES ('transfer_wxpay', '0');
INSERT INTO `pay_config` VALUES ('user_refund', '1');
INSERT INTO `pay_config` VALUES ('verifytype', '1');
INSERT INTO `pay_config` VALUES ('version', '2046');

-- ----------------------------
-- Table structure for pay_domain
-- ----------------------------
DROP TABLE IF EXISTS `pay_domain`;
CREATE TABLE `pay_domain`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL DEFAULT 0,
  `domain` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `addtime` datetime NULL DEFAULT NULL,
  `endtime` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `domain`(`domain`, `uid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pay_domain
-- ----------------------------

-- ----------------------------
-- Table structure for pay_group
-- ----------------------------
DROP TABLE IF EXISTS `pay_group`;
CREATE TABLE `pay_group`  (
  `gid` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `info` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `isbuy` tinyint(1) NOT NULL DEFAULT 0,
  `price` decimal(10, 2) NULL DEFAULT NULL,
  `sort` int(10) NOT NULL DEFAULT 0,
  `expire` int(10) NOT NULL DEFAULT 0,
  `config` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `settings` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `visible` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`gid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pay_group
-- ----------------------------
INSERT INTO `pay_group` VALUES (0, '默认用户组', '{\"1\":{\"type\":\"\",\"channel\":\"-1\",\"rate\":\"\"},\"2\":{\"type\":\"\",\"channel\":\"-1\",\"rate\":\"\"},\"3\":{\"type\":\"\",\"channel\":\"-1\",\"rate\":\"\"}}', 0, NULL, 0, 0, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for pay_invitecode
-- ----------------------------
DROP TABLE IF EXISTS `pay_invitecode`;
CREATE TABLE `pay_invitecode`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `code` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `addtime` datetime NOT NULL,
  `usetime` datetime NULL DEFAULT NULL,
  `uid` int(11) NULL DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `code`(`code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pay_invitecode
-- ----------------------------

-- ----------------------------
-- Table structure for pay_log
-- ----------------------------
DROP TABLE IF EXISTS `pay_log`;
CREATE TABLE `pay_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL DEFAULT 0,
  `type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `date` datetime NOT NULL,
  `ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `city` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `data` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `logincheck`(`ip`, `date`, `uid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pay_log
-- ----------------------------
INSERT INTO `pay_log` VALUES (1, 0, '登录后台', '2025-05-13 21:14:47', '172.71.99.82', NULL, NULL);
INSERT INTO `pay_log` VALUES (2, 0, '登录后台', '2025-05-13 21:37:14', '104.23.168.15', NULL, NULL);
INSERT INTO `pay_log` VALUES (3, 0, '登录后台', '2025-05-13 21:37:43', '104.23.168.15', NULL, NULL);
INSERT INTO `pay_log` VALUES (4, 0, '登录后台', '2025-05-13 21:38:23', '172.71.103.208', NULL, NULL);

-- ----------------------------
-- Table structure for pay_order
-- ----------------------------
DROP TABLE IF EXISTS `pay_order`;
CREATE TABLE `pay_order`  (
  `trade_no` char(19) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `out_trade_no` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `api_trade_no` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `uid` int(11) UNSIGNED NOT NULL,
  `tid` tinyint(11) UNSIGNED NOT NULL DEFAULT 0,
  `type` int(10) UNSIGNED NOT NULL,
  `channel` int(10) UNSIGNED NOT NULL,
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `money` decimal(10, 2) NOT NULL,
  `realmoney` decimal(10, 2) NULL DEFAULT NULL,
  `getmoney` decimal(10, 2) NULL DEFAULT NULL,
  `profitmoney` decimal(10, 2) NULL DEFAULT NULL,
  `refundmoney` decimal(10, 2) NULL DEFAULT NULL,
  `notify_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `return_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `param` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `addtime` datetime NOT NULL,
  `endtime` datetime NULL DEFAULT NULL,
  `date` date NULL DEFAULT NULL,
  `domain` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `domain2` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `buyer` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `notify` int(5) NOT NULL DEFAULT 0,
  `notifytime` datetime NULL DEFAULT NULL,
  `invite` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `invitemoney` decimal(10, 2) NULL DEFAULT NULL,
  `combine` tinyint(1) NOT NULL DEFAULT 0,
  `profits` int(11) NOT NULL DEFAULT 0,
  `profits2` int(11) NOT NULL DEFAULT 0,
  `settle` tinyint(1) NOT NULL DEFAULT 0,
  `subchannel` int(11) NOT NULL DEFAULT 0,
  `payurl` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ext` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `version` tinyint(1) NOT NULL DEFAULT 0,
  `bill_trade_no` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `bill_mch_trade_no` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `mobile` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`trade_no`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE,
  INDEX `out_trade_no`(`out_trade_no`, `uid`) USING BTREE,
  INDEX `api_trade_no`(`api_trade_no`) USING BTREE,
  INDEX `bill_trade_no`(`bill_trade_no`) USING BTREE,
  INDEX `bill_mch_trade_no`(`bill_mch_trade_no`) USING BTREE,
  INDEX `date`(`date`) USING BTREE
);

-- ----------------------------
-- Records of pay_order
-- ----------------------------
INSERT INTO `pay_order` VALUES ('2025051321193890627', 'P1922280571417403392', '2025051321194488573', 1000, 0, 1, 2, 'P1922280571417403392', 30.00, 30.00, 28.20, 0.30, NULL, 'http://110.42.52.227:1000/api/payment/notify/P1922280571417403392.html', 'http://110.42.52.227:1000/api/payment/return/P1922280571417403392.html', NULL, '2025-05-13 21:19:38', '2025-05-13 21:27:23', '2025-05-13', '110.42.52.227:1000', NULL, '223.108.83.108', NULL, 1, 1, '2025-05-13 21:28:23', 0, NULL, 0, 0, 0, 0, 0, NULL, 'a:2:{i:0;s:4:\"jump\";i:1;s:57:\"https://zf11.wew.qkpdk.cn/pay/submit/2025051321194488573/\";}', 0, NULL, NULL, NULL);
INSERT INTO `pay_order` VALUES ('2025051321222612218', '2025051321222556108', NULL, 1001, 0, 1, 2, '支付测试', 1.00, 1.00, 0.94, NULL, NULL, 'https://jlbpay100.top/pay/notify/2025051321222556108/', 'https://jlbpay100.top/pay/return/2025051321222556108/', NULL, '2025-05-13 21:22:26', NULL, NULL, 'jlbpay100.top', NULL, '172.71.98.174', NULL, 0, 0, NULL, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL, 0, NULL, NULL, NULL);
INSERT INTO `pay_order` VALUES ('2025051321223541421', '2025051321223484406', NULL, 1001, 0, 1, 2, '支付测试', 3.00, 3.00, 2.82, NULL, NULL, 'https://jlbpay100.top/pay/notify/2025051321223484406/', 'https://jlbpay100.top/pay/return/2025051321223484406/', NULL, '2025-05-13 21:22:35', NULL, NULL, 'jlbpay100.top', NULL, '172.71.98.174', NULL, 0, 0, NULL, 0, NULL, 0, 0, 0, 0, 0, NULL, 'a:2:{i:0;s:4:\"jump\";i:1;s:57:\"https://zf11.wew.qkpdk.cn/pay/submit/2025051321224171822/\";}', 0, NULL, NULL, NULL);
INSERT INTO `pay_order` VALUES ('2025051321244445853', '2025051321244445853', NULL, 1000, 3, 1, 3, '支付测试', 3.00, 3.00, 3.00, NULL, NULL, 'https://sepptwolves.jlbpay100.top/user/test.php?ok=1&trade_no=2025051321244445853', 'https://sepptwolves.jlbpay100.top/user/test.php?ok=1&trade_no=2025051321244445853', NULL, '2025-05-13 21:24:44', NULL, NULL, 'sepptwolves.jlbpay100.top', NULL, '172.71.99.82', NULL, 0, 0, NULL, 0, NULL, 0, 0, 0, 0, 0, NULL, 'a:2:{i:0;s:4:\"jump\";i:1;s:54:\"https://api3.yktzo.cn/web/pay/1922282054781526016.html\";}', 0, NULL, NULL, NULL);
INSERT INTO `pay_order` VALUES ('2025051321283326644', '2025051321283373504', NULL, 1001, 0, 1, 2, '支付测试', 3.00, 3.00, 2.82, 0.03, NULL, 'https://jlbpay100.top/pay/notify/2025051321283373504/', 'https://jlbpay100.top/pay/return/2025051321283373504/', NULL, '2025-05-13 21:28:33', '2025-05-13 21:28:44', '2025-05-13', 'jlbpay100.top', NULL, '172.71.218.220', NULL, 1, 0, NULL, 0, NULL, 0, 0, 0, 0, 0, NULL, 'a:2:{i:0;s:4:\"jump\";i:1;s:57:\"https://zf11.wew.qkpdk.cn/pay/submit/2025051321283957712/\";}', 0, NULL, NULL, NULL);
INSERT INTO `pay_order` VALUES ('2025051321545622008', '2025051321545622008', NULL, 1000, 3, 1, 4, '支付测试', 10.00, 10.00, 10.00, NULL, NULL, 'https://sepptwolves.jlbpay100.top/user/test.php?ok=1&trade_no=2025051321545622008', 'https://sepptwolves.jlbpay100.top/user/test.php?ok=1&trade_no=2025051321545622008', NULL, '2025-05-13 21:54:56', NULL, NULL, 'sepptwolves.jlbpay100.top', NULL, '104.23.166.53', NULL, 0, 0, NULL, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL, 0, NULL, NULL, NULL);
INSERT INTO `pay_order` VALUES ('2025051321551055945', '2025051321551055945', '1922289526799888384', 1000, 3, 1, 4, '支付测试', 100.00, 100.00, 100.00, -5.00, NULL, 'https://sepptwolves.jlbpay100.top/user/test.php?ok=1&trade_no=2025051321551055945', 'https://sepptwolves.jlbpay100.top/user/test.php?ok=1&trade_no=2025051321551055945', NULL, '2025-05-13 21:55:10', '2025-05-13 21:55:36', '2025-05-13', 'sepptwolves.jlbpay100.top', NULL, '104.23.166.53', NULL, 1, 0, NULL, 0, NULL, 0, 0, 0, 0, 0, NULL, 'a:2:{i:0;s:4:\"jump\";i:1;s:57:\"https://zf11.wew.qkpdk.cn/pay/submit/2025051321551899342/\";}', 0, NULL, NULL, NULL);
INSERT INTO `pay_order` VALUES ('2025051321582246828', '2025051321582149675', NULL, 1002, 0, 1, 4, '支付测试', 100.00, 100.00, 94.00, 1.00, NULL, 'https://jlbpay100.top/pay/notify/2025051321582149675/', 'https://jlbpay100.top/pay/return/2025051321582149675/', NULL, '2025-05-13 21:58:22', '2025-05-13 21:59:10', '2025-05-13', 'jlbpay100.top', NULL, '172.71.215.147', NULL, 1, 0, NULL, 0, NULL, 0, 0, 0, 0, 0, NULL, 'a:2:{i:0;s:4:\"jump\";i:1;s:57:\"https://zf11.wew.qkpdk.cn/pay/submit/2025051321582741003/\";}', 0, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for pay_plugin
-- ----------------------------
DROP TABLE IF EXISTS `pay_plugin`;
CREATE TABLE `pay_plugin`  (
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `showname` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `author` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `link` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `types` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `transtypes` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`name`) USING BTREE
);

-- ----------------------------
-- Records of pay_plugin
-- ----------------------------
INSERT INTO `pay_plugin` VALUES ('adapay', 'AdaPay聚合支付', 'AdaPay', 'https://www.adapay.tech/', 'alipay,wxpay,bank', NULL);
INSERT INTO `pay_plugin` VALUES ('alipay', '支付宝官方支付', '支付宝', 'https://b.alipay.com/signing/productSetV2.htm', 'alipay', 'alipay,bank');
INSERT INTO `pay_plugin` VALUES ('alipaycode', '支付宝免签约码支付', '支付宝', 'https://open.alipay.com/', 'alipay', NULL);
INSERT INTO `pay_plugin` VALUES ('alipayd', '支付宝官方支付直付通版', '支付宝', 'https://b.alipay.com/signing/productSetV2.htm', 'alipay', NULL);
INSERT INTO `pay_plugin` VALUES ('alipayg', '支付宝国际版', '支付宝', 'https://global.alipay.com/', 'alipay', NULL);
INSERT INTO `pay_plugin` VALUES ('alipayrp', '支付宝现金红包', '支付宝', 'https://b.alipay.com/signing/productSetV2.htm', 'alipay', NULL);
INSERT INTO `pay_plugin` VALUES ('alipaysl', '支付宝官方支付服务商版', '支付宝', 'https://b.alipay.com/signing/productSetV2.htm', 'alipay', NULL);
INSERT INTO `pay_plugin` VALUES ('allinpay', '通联支付', '通联', 'https://www.allinpay.com/', 'alipay,wxpay,qqpay,bank', NULL);
INSERT INTO `pay_plugin` VALUES ('chinaums', '银联商务', '银联商务', 'https://open.chinaums.com/', 'alipay,wxpay,bank', NULL);
INSERT INTO `pay_plugin` VALUES ('dinpay', '智付', '智付', 'https://www.dinpay.com/', 'alipay,wxpay,bank', NULL);
INSERT INTO `pay_plugin` VALUES ('duolabao', '哆啦宝支付', '哆啦宝', 'http://www.duolabao.com/', 'alipay,wxpay,qqpay,bank,jdpay', NULL);
INSERT INTO `pay_plugin` VALUES ('easypay', '易生支付', '易生', 'https://www.easypay.com.cn/', 'alipay,wxpay,bank', NULL);
INSERT INTO `pay_plugin` VALUES ('epay', '彩虹易支付', '彩虹', '', 'alipay,qqpay,wxpay,bank,jdpay', NULL);
INSERT INTO `pay_plugin` VALUES ('epayn', '彩虹易支付V2', '彩虹', '', 'alipay,qqpay,wxpay,bank,jdpay', 'alipay,wxpay,qqpay,bank');
INSERT INTO `pay_plugin` VALUES ('fubei', '付呗聚合支付', '付呗', 'https://www.51fubei.com/', 'alipay,wxpay,bank', NULL);
INSERT INTO `pay_plugin` VALUES ('fuiou2', '富友支付(合作方)', '富友', 'https://www.fuiou.com/', 'alipay,wxpay,bank', NULL);
INSERT INTO `pay_plugin` VALUES ('haipay', '海科聚合支付', '海科融通', 'https://www.hkrt.cn/', 'alipay,wxpay,bank', NULL);
INSERT INTO `pay_plugin` VALUES ('heepay', '汇付宝', '汇付宝', 'https://www.heepay.com/', 'alipay,wxpay,bank', 'alipay,wxpay,bank');
INSERT INTO `pay_plugin` VALUES ('hlpay', '汇联支付', '汇联', 'https://www.huilianlink.com/', 'alipay,wxpay,bank', 'alipay,wxpay');
INSERT INTO `pay_plugin` VALUES ('hnapay', '新生支付', '新生支付', 'https://www.hnapay.com/', 'alipay,wxpay,bank', 'bank');
INSERT INTO `pay_plugin` VALUES ('huifu', '汇付斗拱平台', '汇付天下', 'https://paas.huifu.com/', 'alipay,wxpay,bank,ecny', NULL);
INSERT INTO `pay_plugin` VALUES ('huolian', '火脸支付', '火脸', 'https://www.lianok.com/', 'alipay,wxpay,bank', NULL);
INSERT INTO `pay_plugin` VALUES ('jdpay', '京东支付', '京东支付', 'https://www.jdpay.com/', 'jdpay', NULL);
INSERT INTO `pay_plugin` VALUES ('jeepay', 'Jeepay聚合支付', 'Jeepay', 'http://www.xxpay.org/', 'alipay,wxpay,bank', 'alipay,wxpay,bank');
INSERT INTO `pay_plugin` VALUES ('jlpay', '嘉联支付', '嘉联支付', 'https://www.jlpay.com/', 'alipay,wxpay,bank', NULL);
INSERT INTO `pay_plugin` VALUES ('kuaiqian', '快钱支付', '快钱', 'https://www.99bill.com/', 'alipay,wxpay,bank', 'bank');
INSERT INTO `pay_plugin` VALUES ('lakala', '拉卡拉', '拉卡拉', 'https://www.lakala.com/', 'alipay,wxpay,bank', NULL);
INSERT INTO `pay_plugin` VALUES ('ltzf', '蓝兔支付', '蓝兔支付', 'https://www.ltzf.cn/', 'alipay,wxpay', NULL);
INSERT INTO `pay_plugin` VALUES ('passpay', '精秀支付', '精秀', 'https://www.jxpays.com/', 'alipay,wxpay,qqpay,bank', NULL);
INSERT INTO `pay_plugin` VALUES ('paypal', 'PayPal', 'PayPal', 'https://www.paypal.com/', 'paypal', NULL);
INSERT INTO `pay_plugin` VALUES ('qqpay', 'QQ钱包官方支付', 'QQ钱包', 'https://mp.qpay.tenpay.com/', 'qqpay', 'qqpay');
INSERT INTO `pay_plugin` VALUES ('sandpay', '杉德支付', '杉德', 'https://www.sandpay.com.cn/', 'alipay,wxpay,bank', 'bank');
INSERT INTO `pay_plugin` VALUES ('shengpay', '盛付通', '盛付通', 'https://www.shengpay.com/', 'alipay,wxpay,bank', NULL);
INSERT INTO `pay_plugin` VALUES ('stripe', 'Stripe', 'Stripe', 'https://stripe.com/', 'alipay,wxpay,bank,paypal', NULL);
INSERT INTO `pay_plugin` VALUES ('suixingpay', '随行付', '随行付', 'https://www.suixingpay.com/', 'alipay,wxpay,bank', NULL);
INSERT INTO `pay_plugin` VALUES ('swiftpass', '威富通RSA', '威富通', 'https://www.swiftpass.cn/', 'alipay,wxpay,qqpay,bank,jdpay', NULL);
INSERT INTO `pay_plugin` VALUES ('swiftpass2', '威富通MD5', '威富通', 'https://www.swiftpass.cn/', 'alipay,wxpay,qqpay,bank,jdpay', NULL);
INSERT INTO `pay_plugin` VALUES ('umfpay', '联动优势', '联动优势', 'https://xy.umfintech.com/', 'alipay,wxpay,bank', NULL);
INSERT INTO `pay_plugin` VALUES ('unionpay', '银联前置', '银联', 'http://www.95516.com/', 'alipay,wxpay,qqpay,bank,jdpay', NULL);
INSERT INTO `pay_plugin` VALUES ('vmq', 'V免签', 'V免签', 'https://github.com/szvone/vmqphp', 'alipay,qqpay,wxpay', NULL);
INSERT INTO `pay_plugin` VALUES ('woaizf', '我爱支付', '我爱支付', 'https://www.52zhifu.com/', 'alipay,wxpay,qqpay,bank', 'alipay,wxpay');
INSERT INTO `pay_plugin` VALUES ('wxpay', '微信官方支付', '微信', 'https://pay.weixin.qq.com/', 'wxpay', 'wxpay,bank');
INSERT INTO `pay_plugin` VALUES ('wxpayn', '微信官方支付V3', '微信', 'https://pay.weixin.qq.com/', 'wxpay', 'wxpay');
INSERT INTO `pay_plugin` VALUES ('wxpayng', '微信支付国际版V3', '微信', 'https://pay.weixin.qq.com/', 'wxpay', NULL);
INSERT INTO `pay_plugin` VALUES ('wxpaynp', '微信官方支付V3服务商版', '微信', 'https://pay.weixin.qq.com/partner/public/home', 'wxpay', NULL);
INSERT INTO `pay_plugin` VALUES ('wxpaysl', '微信官方支付服务商版', '微信', 'https://pay.weixin.qq.com/partner/public/home', 'wxpay', NULL);
INSERT INTO `pay_plugin` VALUES ('xorpay', 'XorPay', 'XorPay', 'https://xorpay.com/', 'alipay,wxpay', NULL);
INSERT INTO `pay_plugin` VALUES ('xsy', '新生易', '新生易', 'https://www.hnapay.com/', 'wxpay,alipay,bank', NULL);
INSERT INTO `pay_plugin` VALUES ('xunhupay', '虎皮椒支付', '虎皮椒', 'https://www.xunhupay.com/', 'alipay,wxpay', NULL);
INSERT INTO `pay_plugin` VALUES ('yeepay', '易宝支付', '易宝支付', 'https://www.yeepay.com/', 'alipay,wxpay,bank', NULL);
INSERT INTO `pay_plugin` VALUES ('ysepay', '银盛支付', '银盛支付', 'https://www.ysepay.com/', 'alipay,qqpay,wxpay,bank', NULL);
INSERT INTO `pay_plugin` VALUES ('yseqt', '银盛e企通', '银盛', 'https://www.ysepay.com/', 'alipay,wxpay,bank', 'bank');
INSERT INTO `pay_plugin` VALUES ('zhangyishou', '掌易收聚合支付', '掌易收', 'http://www.zhangyishou.com/', 'alipay,qqpay,wxpay,bank', NULL);
INSERT INTO `pay_plugin` VALUES ('zyu', '知宇支付', '知宇', '', 'alipay,qqpay,wxpay,bank', NULL);

-- ----------------------------
-- Table structure for pay_psorder
-- ----------------------------
DROP TABLE IF EXISTS `pay_psorder`;
CREATE TABLE `pay_psorder`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `rid` int(11) NOT NULL,
  `trade_no` char(19) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `api_trade_no` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `settle_no` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `money` decimal(10, 2) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `result` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `addtime` datetime NULL DEFAULT NULL,
  `delay` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `trade_no`(`trade_no`) USING BTREE,
  INDEX `addtime`(`addtime`, `delay`, `status`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pay_psorder
-- ----------------------------

-- ----------------------------
-- Table structure for pay_psreceiver
-- ----------------------------
DROP TABLE IF EXISTS `pay_psreceiver`;
CREATE TABLE `pay_psreceiver`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `channel` int(11) NOT NULL,
  `subchannel` int(11) NULL DEFAULT NULL,
  `uid` int(11) NULL DEFAULT NULL,
  `account` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `rate` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `minmoney` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `addtime` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `channel`(`channel`, `uid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pay_psreceiver
-- ----------------------------

-- ----------------------------
-- Table structure for pay_record
-- ----------------------------
DROP TABLE IF EXISTS `pay_record`;
CREATE TABLE `pay_record`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `action` tinyint(1) NOT NULL DEFAULT 0,
  `money` decimal(10, 2) NOT NULL,
  `oldmoney` decimal(10, 2) NOT NULL,
  `newmoney` decimal(10, 2) NOT NULL,
  `type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `trade_no` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE,
  INDEX `trade_no`(`trade_no`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pay_record
-- ----------------------------
INSERT INTO `pay_record` VALUES (1, 1000, 1, 28.20, 0.00, 28.20, '订单收入', '2025051321193890627', '2025-05-13 21:27:23');
INSERT INTO `pay_record` VALUES (2, 1001, 1, 2.82, 0.00, 2.82, '订单收入', '2025051321283326644', '2025-05-13 21:28:44');
INSERT INTO `pay_record` VALUES (3, 1000, 1, 100.00, 28.20, 128.20, '在线收款', '2025051321551055945', '2025-05-13 21:55:36');
INSERT INTO `pay_record` VALUES (4, 1002, 1, 94.00, 0.00, 94.00, '订单收入', '2025051321582246828', '2025-05-13 21:59:10');

-- ----------------------------
-- Table structure for pay_refundorder
-- ----------------------------
DROP TABLE IF EXISTS `pay_refundorder`;
CREATE TABLE `pay_refundorder`  (
  `refund_no` char(19) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `out_refund_no` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trade_no` char(19) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `uid` int(11) NOT NULL DEFAULT 0,
  `money` decimal(10, 2) NOT NULL,
  `reducemoney` decimal(10, 2) NULL DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `addtime` datetime NULL DEFAULT NULL,
  `endtime` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`refund_no`) USING BTREE,
  INDEX `out_refund_no`(`out_refund_no`, `uid`) USING BTREE,
  INDEX `trade_no`(`trade_no`) USING BTREE
);

-- ----------------------------
-- Records of pay_refundorder
-- ----------------------------

-- ----------------------------
-- Table structure for pay_regcode
-- ----------------------------
DROP TABLE IF EXISTS `pay_regcode`;
CREATE TABLE `pay_regcode`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL DEFAULT 0,
  `scene` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `type` tinyint(1) NOT NULL DEFAULT 0,
  `code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `to` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `time` int(11) NOT NULL,
  `ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `errcount` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `code`(`to`, `type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pay_regcode
-- ----------------------------

-- ----------------------------
-- Table structure for pay_risk
-- ----------------------------
DROP TABLE IF EXISTS `pay_risk`;
CREATE TABLE `pay_risk`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL DEFAULT 0,
  `type` tinyint(1) NOT NULL DEFAULT 0,
  `url` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `content` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `date` datetime NULL DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pay_risk
-- ----------------------------

-- ----------------------------
-- Table structure for pay_roll
-- ----------------------------
DROP TABLE IF EXISTS `pay_roll`;
CREATE TABLE `pay_roll`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` int(11) UNSIGNED NOT NULL,
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `kind` int(1) UNSIGNED NOT NULL DEFAULT 0,
  `info` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `index` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pay_roll
-- ----------------------------

-- ----------------------------
-- Table structure for pay_settle
-- ----------------------------
DROP TABLE IF EXISTS `pay_settle`;
CREATE TABLE `pay_settle`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `batch` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `auto` tinyint(1) NOT NULL DEFAULT 1,
  `type` tinyint(1) NOT NULL DEFAULT 1,
  `account` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `username` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `money` decimal(10, 2) NOT NULL,
  `realmoney` decimal(10, 2) NOT NULL,
  `addtime` datetime NULL DEFAULT NULL,
  `endtime` datetime NULL DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `transfer_no` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `transfer_channel` int(10) UNSIGNED NULL DEFAULT NULL,
  `transfer_status` tinyint(1) NOT NULL DEFAULT 0,
  `transfer_result` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `transfer_date` datetime NULL DEFAULT NULL,
  `transfer_ext` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `result` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE,
  INDEX `batch`(`batch`) USING BTREE,
  INDEX `transfer_no`(`transfer_no`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pay_settle
-- ----------------------------

-- ----------------------------
-- Table structure for pay_subchannel
-- ----------------------------
DROP TABLE IF EXISTS `pay_subchannel`;
CREATE TABLE `pay_subchannel`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `channel` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `info` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `addtime` datetime NULL DEFAULT NULL,
  `usetime` datetime NULL DEFAULT NULL,
  `apply_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `channel`(`channel`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pay_subchannel
-- ----------------------------

-- ----------------------------
-- Table structure for pay_suborder
-- ----------------------------
DROP TABLE IF EXISTS `pay_suborder`;
CREATE TABLE `pay_suborder`  (
  `sub_trade_no` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trade_no` char(19) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `api_trade_no` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `money` decimal(10, 2) NOT NULL,
  `refundmoney` decimal(10, 2) NULL DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `settle` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`sub_trade_no`) USING BTREE,
  INDEX `trade_no`(`trade_no`) USING BTREE
);

-- ----------------------------
-- Records of pay_suborder
-- ----------------------------

-- ----------------------------
-- Table structure for pay_transfer
-- ----------------------------
DROP TABLE IF EXISTS `pay_transfer`;
CREATE TABLE `pay_transfer`  (
  `biz_no` char(19) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `pay_order_no` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `uid` int(11) NOT NULL,
  `type` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `channel` int(10) UNSIGNED NOT NULL,
  `account` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `username` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `money` decimal(10, 2) NOT NULL,
  `costmoney` decimal(10, 2) NULL DEFAULT NULL,
  `addtime` datetime NULL DEFAULT NULL,
  `paytime` datetime NULL DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `api` tinyint(1) NOT NULL DEFAULT 0,
  `desc` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `result` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ext` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`biz_no`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE
);

-- ----------------------------
-- Records of pay_transfer
-- ----------------------------

-- ----------------------------
-- Table structure for pay_type
-- ----------------------------
DROP TABLE IF EXISTS `pay_type`;
CREATE TABLE `pay_type`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `device` int(1) UNSIGNED NOT NULL DEFAULT 0,
  `showname` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `name`(`name`, `device`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pay_type
-- ----------------------------
INSERT INTO `pay_type` VALUES (1, 'alipay', 0, '支付宝', 1);
INSERT INTO `pay_type` VALUES (2, 'wxpay', 0, '微信支付', 1);
INSERT INTO `pay_type` VALUES (3, 'qqpay', 0, 'QQ钱包', 1);
INSERT INTO `pay_type` VALUES (4, 'bank', 0, '网银支付', 0);
INSERT INTO `pay_type` VALUES (5, 'jdpay', 0, '京东支付', 0);
INSERT INTO `pay_type` VALUES (6, 'paypal', 0, 'PayPal', 0);

-- ----------------------------
-- Table structure for pay_user
-- ----------------------------
DROP TABLE IF EXISTS `pay_user`;
CREATE TABLE `pay_user`  (
  `uid` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `gid` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `upid` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `key` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `pwd` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `account` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `username` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `codename` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `settle_id` tinyint(4) NOT NULL DEFAULT 1,
  `alipay_uid` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `qq_uid` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `wx_uid` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `money` decimal(10, 2) NOT NULL,
  `email` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `qq` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `url` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `cert` tinyint(4) NOT NULL DEFAULT 0,
  `certtype` tinyint(4) NOT NULL DEFAULT 0,
  `certmethod` tinyint(4) NOT NULL DEFAULT 0,
  `certno` varchar(18) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `certname` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `certtime` datetime NULL DEFAULT NULL,
  `certtoken` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `certcorpno` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `certcorpname` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `addtime` datetime NULL DEFAULT NULL,
  `lasttime` datetime NULL DEFAULT NULL,
  `endtime` datetime NULL DEFAULT NULL,
  `level` tinyint(1) NOT NULL DEFAULT 1,
  `pay` tinyint(1) NOT NULL DEFAULT 1,
  `settle` tinyint(1) NOT NULL DEFAULT 1,
  `keylogin` tinyint(1) NOT NULL DEFAULT 1,
  `apply` tinyint(1) NOT NULL DEFAULT 0,
  `mode` tinyint(4) NOT NULL DEFAULT 0,
  `status` tinyint(4) NOT NULL DEFAULT 0,
  `refund` tinyint(1) NOT NULL DEFAULT 1,
  `transfer` tinyint(1) NOT NULL DEFAULT 0,
  `keytype` tinyint(1) NOT NULL DEFAULT 0,
  `publickey` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `channelinfo` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `ordername` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `msgconfig` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `remain_money` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `open_code` tinyint(1) NOT NULL DEFAULT 0,
  `deposit` decimal(10, 2) NULL DEFAULT NULL,
  PRIMARY KEY (`uid`) USING BTREE,
  INDEX `email`(`email`) USING BTREE,
  INDEX `phone`(`phone`) USING BTREE
);

-- ----------------------------
-- Records of pay_user
-- ----------------------------
INSERT INTO `pay_user` VALUES (1000, 0, 0, 'fO69knmTNHRKg8KC3p6huKUCofKKoO3M', NULL, '', '', NULL, 1, NULL, NULL, NULL, 128.20, '13838385438@163.com', '13838385438', '', '', 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, '2025-05-13 21:19:26', NULL, NULL, 1, 1, 1, 1, 0, 0, 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, NULL);
INSERT INTO `pay_user` VALUES (1001, 0, 0, 'FWig23FmgCi2wz5FIfB5xf3BqMpicCf2', NULL, '', '', NULL, 1, NULL, NULL, NULL, 2.82, '13868686688@163.com', '13868686688', '', '', 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, '2025-05-13 21:20:37', NULL, NULL, 1, 1, 1, 1, 0, 0, 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, NULL);
INSERT INTO `pay_user` VALUES (1002, 0, 0, '815mOYIYD4I1YzV7YsIMSsyMg11G1mZ3', NULL, '', '', NULL, 1, NULL, NULL, NULL, 94.00, '13838385439@163.com', '13838385439', '', '', 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, '2025-05-13 21:57:36', NULL, NULL, 1, 1, 1, 1, 0, 0, 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, NULL);

-- ----------------------------
-- Table structure for pay_weixin
-- ----------------------------
DROP TABLE IF EXISTS `pay_weixin`;
CREATE TABLE `pay_weixin`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` tinyint(4) UNSIGNED NOT NULL DEFAULT 0,
  `name` varchar(30) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `appid` varchar(150) DEFAULT NULL,
  `appsecret` varchar(250) DEFAULT NULL,
  `access_token` varchar(300) DEFAULT NULL,
  `addtime` datetime NULL DEFAULT NULL,
  `updatetime` datetime NULL DEFAULT NULL,
  `expiretime` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
);

-- ----------------------------
-- Records of pay_weixin
-- ----------------------------

-- ----------------------------
-- Table structure for pay_wework
-- ----------------------------
DROP TABLE IF EXISTS `pay_wework`;
CREATE TABLE `pay_wework`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `appid` varchar(150) DEFAULT NULL,
  `appsecret` varchar(250) DEFAULT NULL,
  `access_token` varchar(300) DEFAULT NULL,
  `addtime` datetime NULL DEFAULT NULL,
  `updatetime` datetime NULL DEFAULT NULL,
  `expiretime` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
);

-- ----------------------------
-- Records of pay_wework
-- ----------------------------

-- ----------------------------
-- Table structure for pay_wxkfaccount
-- ----------------------------
DROP TABLE IF EXISTS `pay_wxkfaccount`;
CREATE TABLE `pay_wxkfaccount`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `wid` int(11) UNSIGNED NOT NULL,
  `openkfid` varchar(60) NOT NULL,
  `url` varchar(100) DEFAULT NULL,
  `cursor` varchar(30) DEFAULT NULL,
  `name` varchar(300) DEFAULT NULL,
  `addtime` datetime NOT NULL,
  `usetime` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `openkfid`(`openkfid`) USING BTREE,
  INDEX `wid`(`wid`) USING BTREE
);

-- ----------------------------
-- Records of pay_wxkfaccount
-- ----------------------------

-- ----------------------------
-- Table structure for pay_wxkflog
-- ----------------------------
DROP TABLE IF EXISTS `pay_wxkflog`;
CREATE TABLE `pay_wxkflog`  (
  `trade_no` char(19) NOT NULL,
  `aid` int(11) UNSIGNED NOT NULL,
  `sid` char(32) NOT NULL,
  `payurl` varchar(500) NOT NULL,
  `addtime` datetime NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`trade_no`) USING BTREE,
  INDEX `sid`(`sid`) USING BTREE,
  INDEX `addtime`(`addtime`) USING BTREE
);

-- ----------------------------
-- Records of pay_wxkflog
-- ----------------------------
