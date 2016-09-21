#!/bin/bash
source ./vars.sh
source ./functions.sh

when_debug "execution_info $# $@"


if [ $# -eq 0 ]
  then
    access_token=$(cat auth_token.json | awk -F'"' '{print $4}')
fi

rm -f ${MARKETODATADIR}/emailtemplates.json
curl ${CURLARGS} -H "Accept: application/json" -H "Content-Type: application/json" -X GET "${MARKETORESTURL}/emailTemplates.json?access_token=${access_token}" -o ${MARKETODATADIR}/emailtemplates.json
check_response "${MARKETODATADIR}/emailtemplates.json"


