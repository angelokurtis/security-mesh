#!/usr/bin/env bash

set -e

watch 'curl -X POST 35.192.70.43/bets ' \
  '-H "Host: football.com" ' \
  '-H "Authorization: Bearer abc" ' \
  '-s -o /dev/null -w "%{http_code}\n"'
