#!/bin/bash
# system ip forwarding required for wireguard
echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
sysctl -p
#ufw settings for ip forwarding and masquerading
echo "net.ipv4.ip_forward=1" >> /etc/ufw/sysctl.conf
echo -e "*nat\n:POSTROUTING ACCEPT [0:0]\n-A POSTROUTING -s 10.0.0.0/8 -o eth0 -j MASQUERADE\nCOMMIT" >> /etc/ufw/before.rules
## install crontab
crontab /root/wg_conf_restart
systemctl enable docker-compose-app