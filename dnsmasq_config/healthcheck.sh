#!/bin/sh

set -eu

if [ -z "${PUB_HEALTH_CHECK_DOMAINS}" ]; then
  echo "No domains to check"
  exit 0
fi

for domain in ${PUB_HEALTH_CHECK_DOMAINS}; do
    echo "${domain}"
    dig -t txt "${domain}" @localhost
    dig -t txt "${domain}" @localhost | grep "ANSWER SECTION"
done
