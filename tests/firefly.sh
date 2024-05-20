#!/bin/sh
. ./tests

check_docker_container "fireflyiii/core"
check_url_status "https://firefly.$1/health"