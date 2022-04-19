#!/usr/bin/sh
mkdir -p ${PWD}/data/traefik
touch -a ${PWD}/data/traefik/traefik.log
touch -a ${PWD}/data/traefik/acme.json
chmod 600 ${PWD}/data/traefik/acme.json

mkdir -p ${PWD}/data/unifi/config

mkdir -p ${PWD}/data/adguard/work
mkdir -p ${PWD}/data/adguard/conf

mkdir -p $${PWD}/data/vaultwarden/data