# flexiwire

Spin up a (manageable) wireguard VPN in Digital Ocean using terraform with minimal effort

## Accounts Required befor you start

1. Digital Ocean account

- create account
- create an API token (API>Tokens/Keys>Generate New Token)
- create an SSH key locally using the command `ssh-keygen -f ./digital_ocean_key -t ed25519 -C "myemailaddress@gmail.com"`
- upload your public key following directions here https://cloud.digitalocean.com/account/security

2. Dynu Account (free tier)

- create account (record username:password)
- select a domain that you will use and make sure it shows in your account
- create an API key

## Tools required on your local machine (mac assumed - can work on linux or windows)

- `git`
- `terraform` (recommend `brew install tfenv` method and follow instructions - 0.14 version tested)
- `curl`
- `rsync`
- recommend reading the `secrets.tfvars.example` file for anything you need to prepare for

## How do I set this up?

1. using git - clone this repository. Enter the directory `flexiwire`
2. rename the file (or copy) `secrets.tfvars.example` to `secrets.tfvars`
3. with your favorite editor - add the necessary secrets from your accounts to `secrets.tfvars`
4. At a command line run a terraform init and plan and see if anything was missed `terraform init && terraform plan --var-file secrets.tfvars`
5. Now apply the config that was planned and it will build out the virtual server `terraform apply --var-file secrets.tfvars`
6. Once the virtual server (droplet) is built, you can connect to it using the command `ssh -i digital_ocean_key root@<ip_address_of_droplet>`
7. The server will download all updates and reboot. This takes approx ten minutes. Be patient.
8. Browse to the web portal that was setup `https://<my_domain_name>` and you should be able to login to the wiregaurd admin page
9. Follow the directions that are provided from the wireguard-ui project to setup VPN users ( https://github.com/ngoduykhanh/wireguard-ui )

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
