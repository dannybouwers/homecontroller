# homecontroller
Personal project to move all tools on my RaspberryPi to Docker. [Photos OS](https://github.com/vmware/photon) is used as host OS (due to minimal footprint and security focus). Docker will be running in [swarm mode](https://docs.docker.com/engine/swarm/swarm-tutorial/) to keep the number of installed packages as low as possible (i.e. no Python for Docker Compose) while I can still use compose files with [Docker stack](https://docs.docker.com/engine/reference/commandline/stack/).

## Configure Photon OS (in VirtualBox)
For optimal security, I don't want to expose the root user to SSH and only create SSH enabled users without password (but with keys). To do this in Photon OS:

Login as root and create a user
```bash
useradd -m -G sudo,docker USERNAME

mkdir /home/USERNAME/.ssh
chmod 700 /home/USERNAME/.ssh

touch /home/USERNAME/.ssh/authorized_keys
chmod 600 /home/USERNAME/.ssh/authorized_keys

chown -R USERNAME:users /home/USERNAME/.ssh
```

Tempory enable SSH for the root user
```bash
sed -i 's/PermitRootLogin no/PermitRootLogin yes/g' /etc/ssh/sshd_config
systemctl restart sshd
```

Add your public key to USERNAME/.ssh/authorized_keys using an SFTP enabled client

Disable SSH for root user
```bash
sed -i 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config
systemctl restart sshd
```

Start docker
```bash
systemctl start docker
systemctl enable docker #enable Docker
docker swarm init #run Docker in Swarm mode
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