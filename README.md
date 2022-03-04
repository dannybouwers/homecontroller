# homecontroller
Personal project to move all tools on my home server to Docker. [Alpine Linux](https://alpinelinux.org/) is used as host OS (due to minimal footprint and security focus). Docker compose is used to manage my local infrastructure in a single file. I use a Linux Container in Proxmox, but it can also run on a Raspberry Pi

## (Optional) configure Alpine Linux
[Configure Alpine Linux](https://github.com/dannybouwers/homecontroller/wiki/Configure-Alpine-Linux)

## (Optional) Host security
[Setup fail2ban](https://github.com/dannybouwers/homecontroller/wiki/Setup-fail2ban)
[Setup firewall](https://github.com/dannybouwers/homecontroller/wiki/Setup-firewall)

## Set environment
The setup uses the following environment variables. These can be set using [docker-compose supported methods](https://docs.docker.com/compose/environment-variables/). I have configured them in my CI/CD pipeline.

| variable | description |
| -------- | ----------- |
| PROXY_WEB_PORT | port for HTTP connections |
| PROXY_WEBSECURE_PORT | port for HTTPS connections |
| LE_EMAIL | e-mail adress for Let's Encrypt |
| TRANSIP_ACCOUNT_NAME | account name for TransIP account to use LE DNS challenges |
| PROXY_DOMAIN | main domain to use for services |
| PROXY_LOCAL_DISKSTATION | address to reach diskstation (used in file provider) |
| PROXY_WHITELIST | Allowed IPs for Traefik dashboard and service admin panels (default 127.0.0.1) |
| DOCKER_USER_ID | ID of the user that should own files created by containers (used by images by linuxserver.io) |
| DOCKER_GROUP_ID | ID of the group that should own files created by containers (used by images by linuxserver.io) |
| CLOUDFLARE_DNS_API_TOKEN | [Cloudflare API token](https://dash.cloudflare.com/profile/api-tokens) with DNS:Edit permission |

The TransIP API key file should be stored as `/home/USERNAME/secrets/transip.key`. It can be obtained via [TransIP API-instellingen](https://www.transip.nl/cp/account/api/)

## Prepare for running
Run the file [setup.sh](setup.sh) to create directories and files mounted by docker compose.

## todo
- [X] [Traefik](https://hub.docker.com/_/traefik/)
- [X] [Unifi Controller](https://github.com/linuxserver/docker-unifi-controller)
- [ ] [Plex](https://github.com/linuxserver/docker-plex)
- [X] [AdGuard Home](https://github.com/AdguardTeam/AdGuardHome/wiki/Docker)
- [X] Synology Disk Station
- [X] Synology Photo Station
- [X] fail2ban
- [ ] [vaultwarden](https://github.com/dani-garcia/vaultwarden)
- [ ] automated test
- [ ] [Uptime Kuma](https://github.com/louislam/uptime-kuma/wiki/%F0%9F%94%A7-How-to-Install)