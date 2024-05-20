#!/bin/sh
. ./tests

check_docker_container "adguard/adguardhome"
check_url_status "https://adguard.$1"