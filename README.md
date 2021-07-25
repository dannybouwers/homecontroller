# homecontroller
Personal project to move all tools on my RaspberryPi to Docker. [Alpine Linux](https://alpinelinux.org/) is used as host OS (due to minimal footprint and security focus). Docker compose is used to manage my local infrastructure in a single file.

## Configure Alpine Linux
To install Docker and Docker-Compose, community repositories should be enabled. Edit the file `/etc/apk/repositories` using an editor (e.g. vi) and uncomment the line that points to the "community" directory (i.e. `https://<mirror-server>/alpine/<version>/community`).

Install and start docker:
```bash
apk update # update package list since community repository is added
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

## Setup fail2ban
Fail2Ban scans log files like and bans IP addresses that make too many password failures. It updates firewall rules to reject the IP address. 

Install and start fail2ban:
```bash
apk add fail2ban #install fail2ban package
rc-update add fail2ban #Enable the fail2ban service so that it starts at boot
/etc/init.d/fail2ban start #Start the fail2ban service immediately and create configuration files
```

Add a jail to fail2ban to block failed login attempts with public keys:
```bash
cat > /etc/fail2ban/filter.d/alpine-sshd-key.conf <<EOF
# Fail2Ban filter for openssh for Alpine
#
# Filtering login attempts with PasswordAuthentication No in sshd_config.
#

[INCLUDES]

# Read common prefixes. If any customizations available -- read them from
# common.local
before = common.conf

[Definition]

_daemon = sshd

failregex = (Connection closed by|Disconnected from) authenticating user .* <HOST> port \d* \[preauth\]

ignoreregex =

[Init]

# "maxlines" is number of log lines to buffer for multi-line regex searches
maxlines = 10
EOF

cat >> /etc/fail2ban/jail.d/alpine-ssh.conf <<EOF

[sshd-key]
enabled  = true
filter   = alpine-sshd-key
port     = ssh
logpath  = /var/log/messages
maxretry = 2
EOF

/etc/init.d/fail2ban restart
```

## Setup firewall
The most easy way to setup a firewall, is by making use of UFW (Uncomplicated Firewall). Luckily, it's available for Alpine Linux:
```bash
apk add ufw
```

For best security, block all incoming traffic by default and open ports once you need them to be open:
```bash
ufw default deny incoming # block incoming by default
ufw default allow outgoing # allow all outgoing
ufw allow ssh # allow ssh, to enable remote management
ufw allow https # allow https, that's where we'll find all proxied services
ufw allow http # allow http, so Traefik can be reached to redirect traffic to https
ufw allow from 192.168.0.0/16 # allow any traffic form LAN, e.g. for Unifi and AdGuard
ufw enable # enable the firewall
```

## Set environment
The setup uses the following environment variables. These can be set using [docker-compose supported methods](https://docs.docker.com/compose/environment-variables/). I have configured them in my IC/CD pipeline.

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

The TransIP API key file should be stored as `/home/USERNAME/secrets/transip.key`. It can be obtained via [TransIP API-instellingen](https://www.transip.nl/cp/account/api/)

## Prepare for running
Run the file [setup.sh](setup.sh) to create directories and files mounted by docker compose.

## todo
- [X] [Traefik](https://hub.docker.com/_/traefik/)
- [X] [Unifi Controller](https://github.com/linuxserver/docker-unifi-controller)
- [ ] [Plex](https://github.com/linuxserver/docker-plex)
- [X] [AdGuard Home](https://github.com/AdguardTeam/AdGuardHome/wiki/Docker)
- [ ] [Home Assistant](https://www.home-assistant.io/docs/installation/docker/)
- [ ] [SeaFile](https://download.seafile.com/published/seafile-manual/docker/deploy%20seafile%20with%20docker.md)
- [X] Synology Disk Station
- [X] Synology Photo Station
- [X] fail2ban
- [ ] [vaultwarden](https://github.com/dani-garcia/vaultwarden)
- [ ] automated test