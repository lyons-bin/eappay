# 环境安装

1. 安装 mysql 8.4.0
2. 安装 PHP 7.4 以上
3. 安装nginx

# 站点创建

1. 下载代码到对应的站点目录

# 站点配置

1. 配置伪静态

   1. 站点目录下的nginx.txt 就是伪静态内容

   ```xml
   location / {
    if (!-e $request_filename) {
      rewrite ^/(.[a-zA-Z0-9\-\_]+).html$ /index.php?mod=$1 last;
    }
    rewrite ^/pay/(.*)$ /pay.php?s=$1 last;
    rewrite ^/api/(.*)$ /api.php?s=$1 last;
    rewrite ^/doc/(.[a-zA-Z0-9\-\_]+).html$ /index.php?doc=$1 last;
   }
   location ^~ /plugins {
     deny all;
   }
   location ^~ /includes {
     deny all;
   }
   ```

2. 配置数据库信息

   1. 站点目录下下的 config.php 配置数据信息

3. 站点配置 PHP 版本

   1. 点击站点, 编辑, php 选择 php 版本

4. 访问站点进行安装配置

   1. 域名/install.php
      





install / init-data.sql 是整个数据库文件备份,
