#!/usr/bin/env bash

set -e

watch -n 0.2 'curl -X POST 34.67.1.190/bets ' \
  '-H "Host: football.com" ' \
  '-H "Authorization: Bearer abc" ' \
  '-s -o /dev/null -w "%{http_code}\n"'
