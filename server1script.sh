#!/bin/bash

#Install syslog-ng
wget -qO - http://download.opensuse.org/repositories/home:/laszlo_budai:/syslog-ng/xUbuntu_17.04/Release.key | sudo apt-key add -
deb http://download.opensuse.org/repositories/home:/laszlo_budai:/syslog-ng/xUbuntu_16.10 ./
apt-get update
apt-get install syslog-ng-core

#Make back-up
cp /etc/syslog-ng/syslog-ng.conf /etc/syslog-ng/syslog-ng.conf
rm /etc/syslog-ng/syslog-ng.conf
cd /etc/syslog-ng/
sudo wget https://raw.githubusercontent.com/lhermans/linuxeindropracht/master/syslog-ng.conf
