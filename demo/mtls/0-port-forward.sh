#!/usr/bin/env bash

set -x

kubectl port-forward deploy/fakebets 9090:9090 -n outsider