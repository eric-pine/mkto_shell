#!/bin/bash

source ./vars.sh

offsetstring='&offset='
offset=0
i=200
if [ $# -eq 0 ]
  then
    echo ' '
    echo ' '
    echo "Correct script usage: get_all_landingpages_json.sh <auth token>"
    access_token=$(cat auth_token.json | awk -F'"' '{print $4}')
  else
    access_token=$1
fi

rm -f ${MARKETODATADIR}/landingpages*
echo "Retreiving landing page list..."

while [ $i -eq 200 ]
do
echo ' '
echo ' '
echo "retrieved ${offset} so far - we can only request 200 at a time"
echo "using request URL : ${MARKETORESTURL}/landingPages.json?access_token=${access_token}&maxReturn=200${offsetstring}${offset}"
curl "${MARKETORESTURL}/landingPages.json?access_token=${access_token}&maxReturn=200${offsetstring}${offset}" -o ${MARKETODATADIR}/landingpages_part_${offset}.json -s
cat ${MARKETODATADIR}/landingpages_part_${offset}.json >> ${MARKETODATADIR}/landingpages.json
i="$(cat ${MARKETODATADIR}/landingpages_part_${offset}.json | grep -o 'http.://[^"]*' | grep html | wc -l)"
offset=$[$offset+200]
done
echo ' '
echo ' '
echo Complete! $[$offset-200+$i] total entries reported retrieved. $(cat ${MARKETODATADIR}/landingpages_part_*.json | grep -o 'http.://[^"]*' | grep html | wc -l) verified in files.
echo ' '
echo ' '

