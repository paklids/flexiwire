version: "3"

services:
  wgui:
    image: ngoduykhanh/wireguard-ui:latest
    container_name: wgui
    environment:
      - SENDGRID_API_KEY
      - EMAIL_FROM
      - EMAIL_FROM_NAME
      - SESSION_SECRET
      - WGUI_USERNAME=${wgui_username}
      - WGUI_PASSWORD=${wgui_password}
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.admin.rule=Host(`${dynu_domain}`)"
      - "traefik.http.routers.admin.entrypoints=websecure"
      - "traefik.http.routers.admin.tls.certresolver=myresolver"
    logging:
      driver: json-file
      options:
        max-size: 100m
    volumes:
      - ./db:/app/db
      - /etc/wireguard:/etc/wireguard
  traefik:
    image: "traefik:v2.4"
    container_name: "traefik"
    command:
      #- "--log.level=DEBUG"
      - "--api.insecure=true"
      - "--providers.docker=true"
      - "--providers.docker.exposedbydefault=false"
      - "--entrypoints.websecure.address=:443"
      - "--certificatesresolvers.myresolver.acme.dnschallenge=true"
      - "--certificatesresolvers.myresolver.acme.dnschallenge.provider=dynu"
      - "--certificatesresolvers.myresolver.acme.caserver=https://acme-staging-v02.api.letsencrypt.org/directory"
      - "--certificatesresolvers.myresolver.acme.email=${le_email_addr}"
      - "--certificatesresolvers.myresolver.acme.storage=/letsencrypt/acme.json"
    ports:
      - "80:80"
      - "443:443"
    environment:
      - "DYNU_API_KEY=${dynu_api_key}"
    logging:
      driver: json-file
      options:
        max-size: 100m
    volumes:
      - "./letsencrypt:/letsencrypt"
      - "/var/run/docker.sock:/var/run/docker.sock:ro"
    depends_on:
      - wgui
