#!/usr/bin/env bash

set -e

curl -X POST football.com/bets -s -o /dev/null -w "%{http_code}\n" \
     -H "Authorization: Bearer deadbeef"
