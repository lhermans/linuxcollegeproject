#!/bin/bash

#Using logger to log everything to syslog-ng, which SHOULD be installed by now.
#logger <string> 

#Install apache
logger installing apache2
sudo apt -y install apache2

#Install relevant PHP dependencies 
logger installing PHP
sudo apt -y install libapache2-mod-php php php-gd php-cli php-xml php-ldap php-mbstring

#Installing MySQL
logger installing and configuring MySQL
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password root"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password root"
sudo apt -y install mysql-server php-mysql

#Setting timezones
logger setting timezones
sed -i -e "s/\;date.timezone =/date.timezone = Europe\/Amsterdam/g" /etc/php/7.0/apache2/php.ini

#Install apache
logger Installing apache2
sudo apt -y install apache2

#Restart apache2
logger restart apache2
/etc/init.d/apache2 restart
