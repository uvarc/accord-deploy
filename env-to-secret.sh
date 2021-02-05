#!/bin/bash

# env-to-secret.sh - simple wrapper for generating a kubernetes secret file
# from a .env file

if [ $# -ne 3 ]
then
    echo "Usage: ./env-to-secret.sh <namespace> <secretname> <envfile>"
    exit 1
fi

kubectl -n "$1" create secret generic "$2" --from-env-file="$3" --dry-run=client -o yaml
