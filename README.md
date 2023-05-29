# homecontroller
Personal project to move all tools on my home server to Docker. [Alpine Linux](https://alpinelinux.org/) is used as host OS (due to minimal footprint and security focus). Docker compose is used to manage my local infrastructure in a single file. I use a Linux Container in Proxmox, but it can also run on a Raspberry Pi

## (Optional) configure Alpine Linux
[Configure Alpine Linux](https://github.com/dannybouwers/homecontroller/wiki/Configure-Alpine-Linux)

## (Optional) Host security
[Setup fail2ban](https://github.com/dannybouwers/homecontroller/wiki/Setup-fail2ban)

[Setup firewall](https://github.com/dannybouwers/homecontroller/wiki/Setup-firewall)

## Set environment
Create a file called ```.env``` in your working directory and copy the contents of [.env.example](.env.example). Replace the contents with your personal details.

## Prepare for running
Run the file [setup.sh](setup.sh) to create directories and files mounted by docker compose.

## todo
- [X] [Traefik](https://hub.docker.com/_/traefik/)
- [X] [Unifi Controller](https://github.com/linuxserver/docker-unifi-controller)
- [X] [AdGuard Home](https://github.com/AdguardTeam/AdGuardHome/wiki/Docker)
- [X] Synology Disk Station
- [X] Synology Photo Station
- [X] fail2ban
- [X] [vaultwarden](https://github.com/dani-garcia/vaultwarden)
- [ ] [Plex](https://github.com/linuxserver/docker-plex)
- [ ] [wg-easy](https://github.com/wg-easy/wg-easy)
- [ ] semi-automated updates
- [ ] automated test
- [ ] [Uptime Kuma](https://github.com/louislam/uptime-kuma/wiki/%F0%9F%94%A7-How-to-Install)