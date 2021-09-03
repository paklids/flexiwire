# flexiwire

Spin up a (manageable) wireguard VPN in Digital Ocean using terraform with minimal effort

You'll need to setup a few accounts first:

1. Digital Ocean account

- create account
- create an API token (API>Tokens/Keys>Generate New Token)

2. Dynu Account

- create account (record username:password)
- select a domain that you will use and make sure it shows in your account
- create an API key

3. On your local machine (mac assumed)

- Install terraform (recommend `brew install tfenv` method and follow directions)
- Make sure you've installed curl & rsync

## Backup what you need to recover from a disaster

the config:
`rsync -a -e "ssh -i digital_ocean_key" root@<ip_address>:/etc/wireguard/wg0.conf ./`

the db (json files):
`rsync -av -e "ssh -i digital_ocean_key" root@<ip_address>:/root/db ./`

## Restore after a disaster (or rebuild whenever you want)

the config:
`rsync -a -e "ssh -i digital_ocean_key" ./wg0.conf root@<ip_address>:/etc/wireguard/wg0.conf`

the db:
`rsync -av --delete -e "ssh -i digital_ocean_key" ./db root@<ip_address>:/root/`
