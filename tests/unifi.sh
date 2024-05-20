#!/bin/sh
. ./tests

check_docker_container "linuxserver/unifi-network-application"
check_url_status "https://unifi.$1/status"