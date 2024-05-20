#!/bin/sh
. ./tests

check_docker_container "traefik"
check_url_status "https://traefik.$1/api/version"