#!/bin/bash
WG_CONF_FILE="/etc/wireguard/wg0.conf"
if [ ! -f "$WG_CONF_FILE" ]; then
    echo "no configuration present at $WG_CONF_FILE  - skip for now"
else
    if [ ! -f /root/wg_sha ]; then
        echo "no shasum capture taken yet so do it now & start the service"
        sha256sum $WG_CONF_FILE | awk '{print $1;}' > /root/wg_sha
        /usr/bin/systemctl start wg-quick@wg0.service
        /usr/sbin/ufw route allow in on wg0 out on eth0
        /usr/sbin/ufw route allow in on eth0 out on wg0
    fi
    WG_CONF_SUM_NOW=$(sha256sum $WG_CONF_FILE | awk '{print $1;}')
    WG_CONF_SUM=$(cat /root/wg_sha)
    if [ "$WG_CONF_SUM" == "$WG_CONF_SUM_NOW" ]; then
        echo "No change to wg config"
    else
        echo "wg config has changed - restarting"
        /usr/bin/systemctl restart wg-quick@wg0.service
        /usr/sbin/ufw route allow in on wg0 out on eth0
        /usr/sbin/ufw route allow in on eth0 out on wg0
        sha256sum $WG_CONF_FILE | awk '{print $1;}' > /root/wg_sha
    fi
fi