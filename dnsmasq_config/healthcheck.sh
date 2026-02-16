#!/bin/bash

set -eu

for domain in ${PUB_HEALTH_CHECK_DOMAINS}; do
    echo "${domain}"
    dig -t txt "${domain}" @localhost
    dig -t txt "${domain}" @localhost | grep "ANSWER SECTION"
done
