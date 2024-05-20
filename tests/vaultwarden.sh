#!/bin/sh
. ./tests

check_docker_container "vaultwarden/server"
check_url_status "https://vaultwarden.$1/alive"