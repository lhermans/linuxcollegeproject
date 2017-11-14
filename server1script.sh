#!/bin/bash

#Install syslog-ng
wget -qO - http://download.opensuse.org/repositories/home:/laszlo_budai:/syslog-ng/xUbuntu_17.04/Release.key | sudo apt-key add -
touch /etc/apt/sources.list.d/syslog-ng-obs.list
echo "deb http://download.opensuse.org/repositories/home:/laszlo_budai:/syslog-ng/xUbuntu_16.10 ./" >> /etc/apt/sources.list.d/syslog-ng-obs.list
apt-get update
apt-get install syslog-ng-core

#Make back-up
cp /etc/syslog-ng/syslog-ng.conf /etc/syslog-ng/syslog-ng.conf
rm /etc/syslog-ng/syslog-ng.conf
cd /etc/syslog-ng/
sudo wget https://raw.githubusercontent.com/lhermans/linuxeindropracht/master/syslog-ng.conf


#Load and execute salt master script
cd /home/ubuntu
wget https://raw.githubusercontent.com/lhermans/linuxeindropracht/master/saltmaster.sh
sudo sh saltmaster.sh

#/etc/salt/master aanpassingen:
#interface: 0.0.0.0 naar 10.3.1.37
#hash_type: md5 naar sha512

salt-master

#Minion-related WIP
#salt-key -F master | grep master.pub | cut -d " " -f3


#Accept all incoming keys
salt-key -A