#!/bin/sh
. ./tests

sleep 10
check_docker_container "fireflyiii/core"

sleep 60
check_url_status "https://firefly.$1/health"