#!/usr/bin/env bash

set -e

TOKEN=$(curl -s POST "http://35.192.70.43:8080/auth/realms/tdc-sp/protocol/openid-connect/token" \
  --header "Content-Type: application/x-www-form-urlencoded" \
  --data-urlencode "username=tiago" \
  --data-urlencode "password=123" \
  --data-urlencode "grant_type=password" \
  --data-urlencode "scope=bets:write" \
  --data-urlencode "client_secret=6f5a869f-eff5-4fea-98d4-b7be00b7a8e0" \
  --data-urlencode "client_id=bets-service" | jq -r .access_token)

watch -n 0.2 -x http -h POST 34.67.1.190/bets \
  Authorization:"Bearer $TOKEN"
