#!/bin/sh
. ./tests

check_docker_container "fireflyiii/data-importer"
check_url_status "https://firefly-importer.$1/health"