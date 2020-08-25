#!/usr/bin/env bash

watch -c -x http -h POST 34.67.1.190/bets 'Host: football.com' 'Authorization: Bearer abc' --style=fruity
