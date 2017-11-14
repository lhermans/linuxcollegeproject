#!/bin/bash

#Install salt related packages
apt-get -y install salt-api
apt-get -y install salt-cloud
apt-get -y install salt-master
apt-get -y install salt-minion
apt-get -y install salt-ssh
apt-get -y install salt-syndic

#/etc/salt/master aanpassingen:
#interface: 0.0.0.0 naar 10.3.1.37
#hash_type: md5 naar sha512

#Minion-related WIP
#salt-key -F master | grep master.pub | cut -d " " -f3


#Accept all incoming keys
salt-key -A

#Make pillar
mkdir /srv/pillar
cd /srv/pillar
wget https://raw.githubusercontent.com/lhermans/linuxeindropracht/master/syslog-ng.conf