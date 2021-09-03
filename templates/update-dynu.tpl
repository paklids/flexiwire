#!/bin/bash
##determine public ip each time so we don't have an order-of-operations problem on tf deployment
ext_if=$(ip route sh | awk '$1 == "default" { print $5 }')
ext_ip=$(ip addr sh "$ext_if" | grep 'inet ' | xargs | awk -F'[ /]' '{ print $2 }')
curl --basic -u "${dynu_credentials}" "https://api.dynu.com/nic/update?hostname=${dynu_domain}&myip=$ext_ip"