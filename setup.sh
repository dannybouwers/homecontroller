#!/usr/bin/sh
mkdir -p ${PWD}/data/traefik
touch -a ${PWD}/data/traefik/traefik.log
touch -a ${PWD}/data/traefik/acme.json
chmod 600 ${PWD}/data/traefik/acme.json

touch -a ${PWD}/data/traefik/acme-cf.json
chmod 600 ${PWD}/data/traefik/acme-cf.json

mkdir -p ${PWD}/data/unifi/config

mkdir -p ${PWD}/data/adguard/work
mkdir -p ${PWD}/data/adguard/conf