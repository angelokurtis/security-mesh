#!/usr/bin/env bash

set -e

TOKEN=$(curl https://raw.githubusercontent.com/istio/istio/release-1.6/security/tools/jwt/samples/demo.jwt -s)
curl -X POST football.com/bets -s -o /dev/null -w "%{http_code}\n" \
     -H "Authorization: Bearer $TOKEN"
