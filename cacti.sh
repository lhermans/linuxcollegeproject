#!/bin/bash

#Install apache
sudo apt -y install apache2

#Install relevant PHP dependencies 
sudo apt -y install libapache2-mod-php php php-gd php-cli php-xml php-ldap php-mbstring

#Installing MySQL
#Password "root" is needed for cacti to work.
echo 'mysql-server mysql-server/root_password password root' | sudo debconf-set-selections
echo 'mysql-server mysql-server/root_password_again password root' | sudo debconf-set-selections
sudo apt -y install mysql-server php-mysql


#Setting timezones
sed -i -e "s/\;date.timezone =/date.timezone = Europe\/Amsterdam/g" /etc/php/7.0/apache2/php.ini

#Install apache
sudo apt -y install apache2

#Restart apache2
/etc/init.d/apache2 restart

#Based on http://forums.cacti.net/download/file.php?id=22710%20-O%20cacti_autoinstall_v0.40c.sh
#Edited script to only use stuff relevant to this project. A lot of plugins weren't at all necessary.

MySQLCactiUser="cactiuser" 			# MYSQL user for cacti database
MySQLCactiPwd="cactipass" 			# Password for the MYSQL user defined above
SystemCactiUser="usercacti" 		# Linux user running cacti
MySQLRootPwd="root" 			# Password for MYSQL user "root"
CactiVersion="1.1.27" 			# Cacti version to be installed
SettingsVersion="0.71-1" 		# Settings plugin version to be installed
SyslogVersion="1.22-2"			# Syslog plugin version to be installed

#Cacti has no timezone for whatever reason...
echo "GRANT SELECT ON mysql.time_zone_name TO cacti@localhost IDENTIFIED BY 'cacti';" | mysql -u root -proot mysql

#Cacti installation below.
#Installing tools.
sudo apt -y install rrdtool snmp snmpd

#Installing cacti
sudo apt -y install rrdtool snmp snmpd php-snmp
cd /usr/src/
wget http://www.cacti.net/downloads/cacti-$CactiVersion.tar.gz
tar zxvf cacti-$CactiVersion.tar.gz
mv ./cacti-$CactiVersion/ /var/www/html/cacti/
mysqladmin -u root -p$MySQLRootPwd create cacti
echo "GRANT ALL ON cacti.* TO "$MySQLCactiUser"@localhost IDENTIFIED BY '"$MySQLCactiPwd"';" | mysql -u root -p$MySQLRootPwd mysql
mysql -u $MySQLCactiUser -p$MySQLCactiPwd cacti < /var/www/html/cacti/cacti.sql
mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql -u root -p$MySQLRootPwd mysql
cd /var/www/html/cacti/include/
sed -i -e "s/username = 'cactiuser'/username = '"$MySQLCactiUser"'/" config.php
sed -i -e "s/password = 'cactiuser'/password = '"$MySQLCactiPwd"'/" config.php
useradd $SystemCactiUser -g www-data -d /var/www/html/cacti -s /bin/false
chown -R $SystemCactiUser:www-data /var/www/html/cacti/rra/ /var/www/html/cacti/log/
chmod -R 770 /var/www/html/cacti/rra/ /var/www/html/cacti/log/
touch /etc/cron.d/cacti
echo "*/5 * * * * $SystemCactiUser php /var/www/html/cacti/poller.php >/dev/null 2>&1" > /etc/cron.d/cacti
rm -f /usr/src/cacti-$CactiVersion.tar.gz

#Installing settings plugins
cd /usr/src/
wget https://docs.cacti.net/_media/plugin:settings-v$SettingsVersion.tgz
mv plugin\:settings-v$SettingsVersion.tgz settings-v$SettingsVersion.tgz
tar zxvf ./settings-v$SettingsVersion.tgz
mv /usr/src/settings/ /var/www/html/cacti/plugins/
rm -f /usr/src/settings-v$SettingsVersion.tgz

#Installig syslog plugins
cd /usr/src/
wget https://docs.cacti.net/_media/plugin:syslog-v$SyslogVersion.tgz
mv plugin\:syslog-v$SyslogVersion.tgz syslog-v$SyslogVersion.tgz
tar zxvf ./syslog-v$SyslogVersion.tgz
mv /usr/src/syslog/ /var/www/html/cacti/plugins/
rm -f /usr/src/syslog-v$SyslogVersion.tgz