#!/usr/bin/sh
mkdir -p ${PWD}/secrets

mkdir -p ${PWD}/data/traefik

mkdir -p ${PWD}/data/unifi/config

mkdir -p ${PWD}/data/adguard/work
mkdir -p ${PWD}/data/adguard/conf

mkdir -p ${PWD}/data/vaultwarden/data

mkdir -p ${PWD}/data/fireflyiii/core
mkdir -p ${PWD}/data/fireflyiii/importer
mkdir -p ${PWD}/data/fireflyiii/db

test -f ${PWD}/secrets/fireflyiii_db_pass && echo 'Secret fireflyiii_db_pass already exists' || echo $(head /dev/urandom | LC_ALL=C tr -dc A-Za-z0-9 | head -c 32) > ${PWD}/secrets/fireflyiii_db_pass
test -f ${PWD}/secrets/fireflyiii_app_key && echo 'Secret fireflyiii_app_key already exists' || echo $(head /dev/urandom | LC_ALL=C tr -dc A-Za-z0-9 | head -c 32) > ${PWD}/secrets/fireflyiii_app_key
test -f ${PWD}/secrets/fireflyiii_static_cron_token && echo 'Secret fireflyiii_static_cron_token already exists' || echo $(head /dev/urandom | LC_ALL=C tr -dc A-Za-z0-9 | head -c 32) > ${PWD}/secrets/fireflyiii_static_cron_token