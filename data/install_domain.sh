#!/bin/bash
#Script Variables
PORT_TCP='1194'
PORT_UDP='2200'

clear
echo "Setup Domain."
mkdir /etc/domain
touch /etc/domain/d-domain
touch /etc/domain/f-domain
wget https://raw.githubusercontent.com/mrtunneldo2024/testovpn/main/data/cf.sh
bash cf.sh
rm cf.sh
clear
