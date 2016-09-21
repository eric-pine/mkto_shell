#!/bin/bash
source ./vars.sh
source ./functions.sh

when_debug "execution_info $# $@"


if [ $# -eq 0 ]
  then
    access_token=$(cat auth_token.json | awk -F'"' '{print $4}')
fi

rm -f ${MARKETODATADIR}/available_segmentations.json
curl ${CURLARGS} -H "Accept: application/json" -H "Content-Type: application/json" -X GET "${MARKETORESTURL}/programs.json?access_token=${access_token}" -o ${MARKETODATADIR}/available_segmentations.json
check_response "${MARKETODATADIR}/available_segmentations.json"


