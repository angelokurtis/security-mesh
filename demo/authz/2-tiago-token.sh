#!/usr/bin/env bash

set -e

TOKEN=$(curl -s POST 'http://35.238.122.239:8080/auth/realms/tdc-sp/protocol/openid-connect/token' \
  --header 'Content-Type: application/x-www-form-urlencoded' \
  --data-urlencode 'username=tiago' \
  --data-urlencode 'password=123' \
  --data-urlencode 'grant_type=password' \
  --data-urlencode 'client_secret=59242778-f253-4d44-b179-af060a6538df' \
  --data-urlencode 'scope=bets:write matches:read' \
  --data-urlencode 'client_id=bets-service' | jq -r .access_token)

watch 'curl -X POST 35.192.70.43/bets ' \
  '-H "Host: football.com" ' \
  '-H "Authorization: Bearer '"$TOKEN"'" ' \
  '-s -o /dev/null -w "%{http_code}\n"'
