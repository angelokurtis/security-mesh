#!/usr/bin/env bash

set -e

KEYCLOAK_URL=${1:-localhost:8080}
echo
echo "KEYCLOAK_URL=$KEYCLOAK_URL"

echo
ADMIN_TOKEN=$(curl -s -X POST \
"http://$KEYCLOAK_URL/auth/realms/master/protocol/openid-connect/token" \
-H "Content-Type: application/x-www-form-urlencoded" \
-d "username=admin" \
-d 'password=admin' \
-d 'grant_type=password' \
-d 'client_id=admin-cli' | jq -r '.access_token')

echo "ADMIN_TOKEN=$ADMIN_TOKEN"

echo "---------"
CLIENT_ID=$(curl -si -X GET "http://$KEYCLOAK_URL/auth/admin/realms/tdc-sp/clients?clientId=bets-service" \
-H "Authorization: Bearer $ADMIN_TOKEN" \
| grep -oE '[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}')

echo "CLIENT_ID=$CLIENT_ID"

echo "---------"
BETS_SERVICE_CLIENT_SECRET=$(curl -s "http://$KEYCLOAK_URL/auth/admin/realms/tdc-sp/clients/$CLIENT_ID/client-secret" \
-H "Authorization: Bearer $ADMIN_TOKEN" | jq -r '.value')

echo "BETS_SERVICE_CLIENT_SECRET=$BETS_SERVICE_CLIENT_SECRET"

echo "---------"
ROLE_ID=$(curl -s "http://$KEYCLOAK_URL/auth/admin/realms/tdc-sp/clients/$CLIENT_ID/roles" \
-H "Authorization: Bearer $ADMIN_TOKEN" | jq -r '.[0].id')

echo "ROLE_ID=$ROLE_ID"

echo "---------"
TIAGO_ID=$(curl -s "http://$KEYCLOAK_URL/auth/admin/realms/tdc-sp/users?username=tiago" \
-H "Authorization: Bearer $ADMIN_TOKEN" | jq '.[0].id')

echo "TIAGO_ID=$TIAGO_ID"

echo "---------"
echo "Getting Tiago's access token"

TIAGO_ACCESS_TOKEN=$(curl -s -X POST \
"http://$KEYCLOAK_URL/auth/realms/tdc-sp/protocol/openid-connect/token" \
-H "Content-Type: application/x-www-form-urlencoded" \
-d "username=tiago" \
-d "password=123" \
-d "grant_type=password" \
-d "client_secret=$BETS_SERVICE_CLIENT_SECRET" \
-d "client_id=bets-service" | jq -r .access_token)

echo "TIAGO_ACCESS_TOKEN=$TIAGO_ACCESS_TOKEN"
echo "---------"