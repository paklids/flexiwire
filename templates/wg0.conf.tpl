[Interface]
PrivateKey = ${privatekey}
Address = 10.0.0.1/24
#Address = fd42:feed:feed:feed::1/64
ListenPort = 51820

[Peer]
PublicKey = ${publickey}
AllowedIPs = 10.0.0.2/32
#AllowedIPs = 10.0.0.2/32, ::/0