#!/bin/bash

#Edit hosts file.
echo '127.0.1.1 SaltStackMinionLex' >> /etc/hosts
echo '10.3.1.37 salt' >> /etc/hosts

sudo apt-get -y install salt-minion
sudo salt-minion -d
