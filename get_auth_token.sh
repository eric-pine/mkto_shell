#!/bin/bash

# This script requests a new authorization token for the Marketo REST API

source ./vars.sh
source ./functions.sh


if [ ${MARKETODEBUG} ] ; then
  echo "command: $0"
  echo "arguments: $@ "
fi

if [ $# -eq 0 ]
  then
    echo "Correct script usage: get_auth_token.sh <client id> <client secret> <output file>"
  else
    client_id=$1
    client_secret=$2
    output_file=$3
fi

if [ ${MARKETODEBUG} ] ; then
  echo curl ${CURLARGS} ${MARKETOAUTHURL}?grant_type=client_credentials&client_id=${client_id}&client_secret=${client_secret} -o ${output_file}
fi

rm -f $output_file
curl ${CURLARGS} "$MARKETOAUTHURL/token?grant_type=client_credentials&client_id=$client_id&client_secret=$client_secret" -o "$output_file"

if [ -n $(cat "$output_file" | jq -r '.["access_token"]') ]
  then
    echo -e "\n\e[32mSUCCESS!\e[0m"
    echo -e "\e[32$(cat "$output_file" | jq -r '.["access_token"]')\e[0m\n\n"
    echo "response saved in $output_file"
    export querycount=0
  else
    echo -e "\n\n\e[31mFailure!\e[0m\n\n"
    echo "Errors: $(cat "$output_file" | jq -r '.["errors"]')"    
fi
