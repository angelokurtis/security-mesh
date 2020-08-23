#!/usr/bin/env bash

set -e

watch 'curl -X POST localhost:9090/bets ' \
  '-H "Authorization: Bearer '"$TOKEN"'" ' \
  '-s -o /dev/null -w "%{http_code}\n"'
