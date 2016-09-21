#!/bin/bash
source ./vars.sh
source ./functions.sh

when_debug "execution_info $# $@"


if [ $# -eq 0 ]
  then
    access_token=$(cat auth_token.json | awk -F'"' '{print $4}')
fi

rm -f ${MARKETODATADIR}/programs.json
curl ${CURLARGS} -H "Accept: application/json" -H "Content-Type: application/json" -X GET "${MARKETORESTURL}/programs.json?access_token=${access_token}" -o ${MARKETODATADIR}/programs.json
check_response "${MARKETODATADIR}/programs.json"


