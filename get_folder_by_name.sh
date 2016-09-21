#!/bin/bash
source ./vars.sh
source ./functions.sh

when_debug "execution_info $# $@"
correctusage="$0 [auth token] <foldername>"


if [ $# -eq 1 ]
  then
    folder=$1
fi
if [ $# -eq 2 ]
  then
    access_token=$1
    folder=$2
fi

when_debug "echo retrieving Marketing Activities folder info" 
rm -f ${MARKETOFOLDERPATH}/Marketing_Activities_by_name.json
curl ${CURLARGS} -H "Accept: application/json" -H "Content-Type: application/json" -X GET "${MARKETORESTURL}/folder/byName.json?name=${folder}&type=Folder&access_token=${access_token}" -o ${MARKETOFOLDERPATH}/${folder}_by_name.json 
check_response "${MARKETOFOLDERPATH}/${folder}_by_name.json"

