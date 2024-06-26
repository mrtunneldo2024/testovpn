#!/bin/bash
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=$(date +"%Y-%m-%d" -d "$dateFromServer")
###########- PERMISSION CODE-##############
NC="\e[0m"
RED="\033[0;31m" 

BURIQ () {
    curl -sS https://raw.githubusercontent.com/mrtunneldo2024/testovpn/main/premission/vps-access > /root/tmp
    data=( $(cat /root/tmp | grep -E "^### " | awk '{print $2}') )
    for user in "${data[@]}"
    do
        exp=$(grep -E "^### $user" "/root/tmp" | awk '{print $3}')
        d1=$(date -d "$exp" +%s)
        d2=$(date -d "$biji" +%s)
        exp2=$(( (d1 - d2) / 86400 ))
        if [[ "$exp2" -le "0" ]]; then
            echo $user > /etc/.$user.ini
        else
            rm -f /etc/.$user.ini > /dev/null 2>&1
        fi
    done
    rm -f /root/tmp
}

MYIP=$(curl -sS ipv4.icanhazip.com)
Name=$(curl -sS https://raw.githubusercontent.com/mrtunneldo2024/testovpn/main/premission/vps-access | grep $MYIP | awk '{print $2}')
echo $Name > /usr/local/etc/.$Name.ini
CekOne=$(cat /usr/local/etc/.$Name.ini)

Bloman () {
    if [ -f "/etc/.$Name.ini" ]; then
        CekTwo=$(cat /etc/.$Name.ini)
        if [ "$CekOne" = "$CekTwo" ]; then
            res="Expired"
        fi
    else
        res="Permission Accepted..."
    fi
}

PERMISSION () {
    MYIP=$(curl -sS ipv4.icanhazip.com)
    IZIN=$(curl -sS https://raw.githubusercontent.com/mrtunneldo2024/testovpn/main/premission/vps-access | awk '{print $4}' | grep $MYIP)
    if [ "$MYIP" = "$IZIN" ]; then
        Bloman
    else
        echo -e "\033[1;96m──────────────────────────────────\033[0m"
        echo -e "\033[1;31m        PERMISSION DENIED\033[0m"
        echo -e "\033[1;96m──────────────────────────────────\033[0m"
        echo -e "\033[1;97mContact admin to register your vps\033[0m"
        echo -e "\033[1;97m in the script\033[0m"
        echo -e "\033[1;94mTelegram: t.me/IlyassExE\033[0m"
        echo -e "\033[1;92mWhatsapp: wa.me/+447886100711\033[0m"
        echo -e "\033[1;96m──────────────────────────────────\033[0m"
        echo -e "\033[1;97m         SCRIPT BY ILYASS\033[0m"
        echo -e "\033[1;96m──────────────────────────────────\033[0m"
        exit 0
    fi
    BURIQ
}
red='\e[1;31m'
green='\e[1;32m'
NC='\e[0m'
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }
PERMISSION
if [ -f /home/needupdate ]; then
    red "Your script need to update first !"
    exit 0
elif [ "$res" = "Permission Accepted..." ]; then
    echo -ne
else
    red "Permission Denied!"
    exit 0
fi

#Script Variables
PORT_TCP='1194'
PORT_UDP='2200'

echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
sysctl -p
    
apt install -y linux-generic-hwe-20.04
grub-set-default 0
echo "tcp_bbr" >> /etc/modules-load.d/modules.conf
INSTALL_BBR=true
sudo sysctl -p
sudo iptables -t nat -A POSTROUTING -o eth0 -s 10.20.0.0/16 -j MASQUERADE
sudo iptables -t nat -A POSTROUTING -o eth0 -s 10.30.0.0/16 -j MASQUERADE
echo iptables-persistent iptables-persistent/autosave_v4 boolean true | sudo debconf-set-selections
echo iptables-persistent iptables-persistent/autosave_v6 boolean true | sudo debconf-set-selections
sudo apt-get install iptables-persistent -y
sudo iptables -t nat -A POSTROUTING -o eth0 -s 10.20.0.0/16 -j MASQUERADE
sudo iptables -t nat -A POSTROUTING -o eth0 -s 10.30.0.0/16 -j MASQUERADE
