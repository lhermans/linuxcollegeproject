#!/bin/bash

#Reads IP address needed to receive syslog logs.
echo $'\nEnter IP address:\n'
read ipaddrng
echo $'\n'
sed -i 's/#source s_net { tcp(ip(127.0.0.1) port(1000)); };/source s_network { syslog(ip($ipaddrng) transport("tcp")); };/g' /etc/syslog-ng/syslog-ng.conf