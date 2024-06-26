#!/bin/bash -ex
# Updated Amazon Linux 2
sudo su -
yum -y update
# Instalar Apache2 - PHP - Banco de Dados MySQL
yum -y install httpd php
# Habilitar Apache2
/usr/bin/systemctl enable httpd
# Iniciar Apache2
/usr/bin/systemctl start httpd
# Habilitar Web-APP
cd /var/www/html
wget https://aws-tc-largeobjects.s3.amazonaws.com/CUR-TF-100-ACCLFO-2/lab5-rds/lab-app-php7.zip
unzip lab-app-php7.zip -d /var/www/html/
chown apache:root /var/www/html/rds.conf.php

