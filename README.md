# homecontroller
Personal project to move all tools on my RaspberryPi to Docker. [Alpine Linux](https://alpinelinux.org/) is used as host OS (due to minimal footprint and security focus). Docker compose is used to manage my local infrastructure in a single file.

## Configure Alpine Linux
To install Docker and Docker-Compose, community repositories should be enabled. Edit the file `/etc/apk/repositories` using an editor (e.g. vi) and uncomment the line that points to the "community" directory (i.e. `https://<mirror-server>/alpine/<version>/community`).

Install and start docker:
```bash
apk upgrade # update package list since community repository is added
apk add docker docker-compose # install docker and docker compose
rc-update add docker boot # configure docker to start at boot
service docker start # start docker
```

For optimal security, I don't want to expose the root user to SSH and only create SSH enabled users without password (but with keys). To do this:

Login on the server as root and create a user
```bash
adduser USERNAME
# set any easy password, we are removing it anyway
addgroup USERNAME docker
addgroup USERNAME users
```

Add your public key by running this command on the machine from which you want to login (assuming you already generated a key pair)
```bash
ssh-copy-id -i ~/.ssh/id_rsa.pub USERNAME@SERVER
# If you don't own the private key (e.g. the key for your cloud CI/CD provider)
# cat ~/.ssh/KEY.pub | ssh USERNAME@SERVER "cat - >> ~/.ssh/authorized_keys"
```

Back on the server, harden your SSH config
```bash
sed -i 's|\(USERNAME\):[^:]*:|\1:\*:|' /etc/shadow # completely disable password login for user
sed -i 's|^.\?\+PasswordAuthentication yes$|PasswordAuthentication no|g' /etc/ssh/sshd_config # disable disable password login for SSH
sed -i 's|^PermitRootLogin yes$|PermitRootLogin no|g' /etc/ssh/sshd_config # disable SSH access for root user
service sshd restart
```

## Set environment
The setup should fetch configuration based on the environment it's running on. I use a virtual test machine and a RaspberyPi as live machine. The following Environment variables sould be set:
```bash
export PROXY_WEB_PORT= #port for HTTP connections
export PROXY_WEBSECURE_PORT= #port for HTTPS connections
export LE_EMAIL= #e-mail adress for Let's Encrypt
export TRANSIP_ACCOUNT_NAME= #account name for TransIP account to use LE DNS challenges
export PROXY_DOMAIN= #main domain to use for services
export PROXY_LOCAL_DISKSTATION= #address to reach diskstation (used in file provider)
```

The TransIP API key file should be stored as `/home/USERNAME/secrets/transip.key`. It can be obtained via [TransIP API-instellingen](https://www.transip.nl/cp/account/api/)

## Prepare for running
Run the file [setup.sh](setup.sh) to create directories and files mounted by docker compose.

## todo
- [X] [Traefik](https://hub.docker.com/_/traefik/)
- [X] [Unifi Controller](https://github.com/linuxserver/docker-unifi-controller)
- [ ] [Plex](https://github.com/linuxserver/docker-plex)
- [ ] [AdGuard Home](https://github.com/AdguardTeam/AdGuardHome/wiki/Docker)
- [ ] [Home Assistant](https://www.home-assistant.io/docs/installation/docker/)
- [ ] [SeaFile](https://download.seafile.com/published/seafile-manual/docker/deploy%20seafile%20with%20docker.md)
- [X] Synology Disk Station
- [X] Synology Photo Station
- [ ] fail2ban
- [ ] [bitwarden_rs](https://github.com/dani-garcia/bitwarden_rs)
- [ ] automated test