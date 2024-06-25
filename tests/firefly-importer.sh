#!/bin/sh
. ./tests

sleep 10
check_docker_container "fireflyiii/data-importer"

sleep 60
check_url_status "https://firefly-importer.$1/health"