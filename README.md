# homecontroller

Personal project to move all tools on my home server to Docker. [Alpine Linux](https://alpinelinux.org/) is used as host OS (due to minimal footprint and security focus). Docker compose is used to manage my local infrastructure in a single file. I use a Linux Container in Proxmox, but it can also run on a Raspberry Pi

## features

- Wildcard Let's Encrypt certificates
- Automated certificate renewal
- Redirect HTTP to HTTPS for all services
- IP whitelist protection for admin pages
- Automated redirect of Synology mailstation and webstation
- Bind mounts for persistent data (easy backups)
- Sensitive Vaultwarden configuration in docker secrets
- Firefly III with PostgreSQL database and data importer

## Usage

### (Optional) configure Alpine Linux

[Configure Alpine Linux](https://github.com/dannybouwers/homecontroller/wiki/Configure-Alpine-Linux)

### (Optional) Host security

[Setup fail2ban](https://github.com/dannybouwers/homecontroller/wiki/Setup-fail2ban)

[Setup firewall](https://github.com/dannybouwers/homecontroller/wiki/Setup-firewall)

### Create a folder

Copy this repository, e.g. by downloading the zip-file and extract it.

```bash
# apk add zip
wget https://github.com/dannybouwers/homecontroller/archive/refs/heads/master.zip
unzip ./master.zip
cd ./homecontroller-master
```

This directory is further referred to as 'working directory'.

### Set environment

Rename [.env.example](.env.example) to ```.env``` (or create a new file) and replace the contents with your personal details.

```bash
mv ./.env.example .env
```

### Create secrets

Create the following text files in your working directory an fill them with the corresponding secret values:

```bash
echo "your-cloudflare-api-token" > ./secrets/cloudflare_api_token
echo "your-google-smpt-password" > ./secrets/google_smtp_pass
echo "a-password-for-the-vaultwarden-admin-page" > ./secrets/vaultwarden_admin_token
```

### Prepare for running

Run the file [setup.sh](setup.sh) to create directories and files mounted by docker compose:

```bash
. ./setup.sh
```

### Run

Start the containers using docker compose:

```bash
docker compose up -d --remove-orphans
```

### Test

Test if everything is running using:

```bash
. ./test.sh
```

### Access services

If DNS is set up correctly, the services can be reached (and configured) using these urls:

- Traefik: https://traefik.example.com
- Unifi Controller: https://unifi.example.com
- AdGuard Home: https://adguard.example.com
- Vaultwarden: https://vaultwarden.example.com
- Vaultwarden admin: https://vaultwarden.example.com/admin
- Firefly III: https://firefly.example.com
- Firefly III Data Importer: https://firefly-importer.example.com
- Synology DSM: https://nas.example.com
- Synology webstation: https://PROXY_WEBSTATION_SUBDOMAIN.example.com

## todo

- [X] [Traefik](https://hub.docker.com/_/traefik/)
- [X] [Unifi Controller](https://github.com/linuxserver/docker-unifi-controller)
- [X] [AdGuard Home](https://github.com/AdguardTeam/AdGuardHome/wiki/Docker)
- [X] Synology Disk Station
- [X] Synology Photo Station
- [X] fail2ban
- [X] [vaultwarden](https://github.com/dani-garcia/vaultwarden)
- [ ] [Plex](https://github.com/linuxserver/docker-plex)
- [ ] [SnappyMail](https://github.com/the-djmaze/snappymail/tree/master/examples/docker)
- [x] [Firefly III](https://docs.firefly-iii.org/firefly-iii/installation/docker/)
- [x] semi-automated updates
- [x] automated test