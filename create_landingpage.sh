#!/bin/bash
source ./vars.sh
source ./functions.sh

when_debug "execution_info $# $@"


if [ $# -eq 0 ]
  then
    access_token=$(cat auth_token.json | awk -F'"' '{print $4}')
    queryurl="${MARKETORESTURL}/landingPages.json?access_token=${access_token}"
    responsetemp=${MARKETOSCRIPTPATH}/curl_temp/create_landingpage.json
    name='API Test Page 3'
    folderid=726
    templateid=1639
    description="\"this is a test\""
    workspace='Default'
    title="\"API Test Page 3\""
    keywords="test"
    formprefill='false'
    folder='{"type": "Folder", "id": '${folderid}'}'
    body="name=${name}&folder=${folder}&template=${templateid}&description=${description}&Workspace=${workspace}&title=${title}&formPrefill=${formprefill}"
fi

rm -f ${responsetemp}
echo ${body} | curl ${CURLARGS} -X POST -d @- ${queryurl} -o ${responsetemp}
check_response "${responsetemp}"

newid=$(cat ${responsetemp} | jq '.["result"][]["id"]')
echo "The new template id is "$newid
