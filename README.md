# homecontroller
Personal project to move all tools on my RaspberryPi to Docker. [Photos OS](https://github.com/vmware/photon) is used as host OS (due to minimal footprint and security focus). Docker will be running in [swarm mode](https://docs.docker.com/engine/swarm/swarm-tutorial/) to keep the number of installed packages as low as possible while I can still use compose files with [Docker stack](https://docs.docker.com/engine/reference/commandline/stack/).

## Configure Photon OS
For optimal security, I don't want to expose the root user to SSH and only create SSH enabled users without password (but with keys). To do this in Photon OS:

Login as root and create a user
```bash
useradd -m -G sudo USERNAME
usermod -aG docker USERNAME
mkdir /home/USERNAME/.ssh
cd /home/USERNAME
chmod 700 ./.ssh
chown -R USERNAME:users ./.ssh/
cd ./.ssh
touch authorized_keys
chmod 600 authorized_keys
```

Tempory enable SSH for the root user
```bash
sed -i 's/PermitRootLogin no/PermitRootLogin yes/g' /etc/ssh/sshd_config
systemctl restart sshd
```

Add your public key to USERNAME/.ssh/authorized_keys using an SFTP enebled client

Disable SSH for root user
```bash
sed -i 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config
systemctl restart sshd
```

Start docker
```bash
systemctl start docker
systemtcl enable docker
```

## Set enviropnment variables
The setup should fetch configuration based on the environment it's running on. I use a virtual test machine and a RaspberyPi as live machine. The following Environment variables sould be set:
```bash
export PROXY_WEB_PORT=8008 #port for HTTP connections
export PROXY_WEBSECURE_PORT=44300 #port for HTTPS connections
export LE_EMAIL= #e-mail adress for Let's Encrypt
export TRANSIP_ACCOUNT_NAME= #account name for TransIP account to use LE DNS challenges
export PROXY_DOMAIN= #main domain to use for services
```

The TransIP API key file should be stored as `/home/USERNAME/traefik/transip.key`. It can be obtained via [TransIP API-instellingen](https://www.transip.nl/cp/account/api/)


## todo
- [X] [Traefik](https://hub.docker.com/_/traefik/)
- [X] [Unifi Controller](https://github.com/linuxserver/docker-unifi-controller)
- [ ] [Plex](https://github.com/linuxserver/docker-plex)
- [ ] [AdGuard Home](https://github.com/AdguardTeam/AdGuardHome/wiki/Docker)
- [ ] [Home Assistant](https://www.home-assistant.io/docs/installation/docker/)
- [ ] [SeaFile](https://download.seafile.com/published/seafile-manual/docker/deploy%20seafile%20with%20docker.md)
- [ ] Synology Disk Station
- [ ] Synology Photo Station