#!/bin/bash

wget -qO - http://download.opensuse.org/repositories/home:/laszlo_budai:/syslog-ng/xUbuntu_17.04/Release.key | sudo apt-key add -
deb http://download.opensuse.org/repositories/home:/laszlo_budai:/syslog-ng/xUbuntu_16.10 ./
apt-get update
apt-get install syslog-ng-core