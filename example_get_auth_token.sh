#!/bin/bash

# This script tests the script that requests a new authorization token for the Marketo REST API

source ./vars.sh

if [ $# -eq 0 ]
  then
    echo "Correct script usage: test_get_auth_token.sh <client id> <client secret>"
    secrets_file=/root/secrets
    client_id=$(grep client_id ${secrets_file} | awk -F'"' '{print $2}')
    client_secret=$(grep client_secret ${secrets_file} | awk -F'"' '{print $2}')
    output_file=${MARKETOSCRIPTPATH}/'auth_token.json'
  else
    client_id=$1
    client_secret=$2
    output_file=$3
fi

./get_auth_token.sh "$client_id" "$client_secret" "$output_file"
