#!/bin/bash
source ./vars.sh
source ./functions.sh

when_debug "execution_info $# $@"


if [ $# -eq 0 ]
  then
    access_token=$(cat auth_token.json | awk -F'"' '{print $4}')
  else
    access_token=$1
    folder=$2
fi


${MARKETOSCRIPTPATH}/get_folder_by_name.sh Marketing%20Activities
folderid=$(cat ${MARKETOFOLDERPATH}/Marketing%20Activities_by_name.json | jq -r '.["result"][]["id"]')
curl ${CURLARGS} -H "Accept: application/json" -H "Content-Type: application/json" -X GET "${MARKETORESTURL}/folders.json?root=\{\"id\":${folderid},\"type\":\"Folder\"\}&maxDepth=5&access_token=${access_token}" -o ${MARKETOFOLDERPATH}/Marketing_Activities_root.json
check_response "${MARKETOFOLDERPATH}/Marketing_Activities_root.json"

${MARKETOSCRIPTPATH}/get_folder_by_name.sh Design%20Studio
folderid=$(cat ${MARKETOFOLDERPATH}/Design%20Studio_by_name.json | jq -r '.["result"][]["id"]')
curl ${CURLARGS} -H "Accept: application/json" -H "Content-Type: application/json" -X GET "${MARKETORESTURL}/folders.json?root=\{\"id\":${folderid},\"type\":\"Folder\"\}&maxDepth=5&access_token=${access_token}" -o ${MARKETOFOLDERPATH}/Design_Studio_root.json
check_response "${MARKETOFOLDERPATH}/Design_Studio_root.json"

