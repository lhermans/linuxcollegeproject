#!/bin/bash

#Reads IP address needed to receive syslog logs. NOTE: Enter the address of the RECEIVING host.
echo $'\nEnter IP address:\n'
read ipaddrng
echo $'\n'
sed -i 's/syslog(ip(10.0.0.0)/syslog(ip($ipaddrng)/g' /etc/syslog-ng/syslog-ng.conf
/etc/init.d/syslog restart