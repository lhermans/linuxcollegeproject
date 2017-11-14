#!/bin/bash

#Install syslog-ng
wget -qO - http://download.opensuse.org/repositories/home:/laszlo_budai:/syslog-ng/xUbuntu_17.04/Release.key | sudo apt-key add -
touch /etc/apt/sources.list.d/syslog-ng-obs.list
echo "deb http://download.opensuse.org/repositories/home:/laszlo_budai:/syslog-ng/xUbuntu_16.10 ./" >> /etc/apt/sources.list.d/syslog-ng-obs.list
apt-get update
apt-get install syslog-ng-core

#Make back-up
cp /etc/syslog-ng/syslog-ng.conf /etc/syslog-ng/syslog-ng.conf.orig
rm /etc/syslog-ng/syslog-ng.conf
cd /etc/syslog-ng/
sudo wget https://raw.githubusercontent.com/lhermans/linuxeindropracht/master/syslog-ng.conf

#Install cacti
cd /home/ubuntu
wget https://raw.githubusercontent.com/lhermans/linuxeindropracht/master/saltmaster.sh
sudo sh cacti.sh
#Load and execute salt master script
cd /home/ubuntu
wget https://raw.githubusercontent.com/lhermans/linuxeindropracht/master/saltmaster.sh
sudo sh saltmaster.sh

