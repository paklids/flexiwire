#!/bin/bash
# system ip forwarding required for wireguard
echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
echo "net.ipv6.conf.all.forwarding=1" >> /etc/sysctl.conf
sysctl -p
#ufw settings for ip forwarding and masquerading
echo "net.ipv4.ip_forward=1" >> /etc/ufw/sysctl.conf
echo "net.ipv6.conf.all.forwarding=1" >> /etc/ufw/sysctl.conf

cat /etc/ufw/before-ipv4.rules >> /etc/ufw/before.rules
cat /etc/ufw/before-ipv6.rules >> /etc/ufw/before6.rules

## install crontab
crontab /root/wg_conf_restart

