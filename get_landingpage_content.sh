#!/bin/bash

source ./vars.sh
source ./functions.sh

if [ $# -eq 0 ]
  then
    echo "Correct script usage: get_landingPages_content.sh <auth token>"
    access_token=$(cat auth_token.json | awk -F'"' '{print $4}')
    inputfile=${MARKETODATADIR}/landingpages.json
  elif [ $# -eq 1 ]
  then
  inputfile=$1
  else
    access_token=$1
    inputfile=$2
fi

echo "Retreiving landing page data..."

cat ${inputfile} | jq -r '.["result"][]["id"]' |\
while read id
do
  rm -rf ${MARKETODATADIR}/landingpages/${id}
  echo -e "\ngetting landing page content for id ${id}"
  mkdir -p ${MARKETODATADIR}/landingpages/${id}
  check_querycount
  curl ${CURLOPTS} "${MARKETORESTURL}/landingPage/${id}.json?access_token=${access_token}" -o ${MARKETODATADIR}/landingpages/${id}/landingpage_${id}.json -s
  check_response "${MARKETODATADIR}/landingpages/${id}/landingpage_${id}.json"
  check_querycount
  curl ${CURLOPTS} "${MARKETORESTURL}/landingPage/${id}/content.json?access_token=${access_token}" -o ${MARKETODATADIR}/landingpages/${id}/content_${id}.json -s
  check_response "${MARKETODATADIR}/landingpages/${id}/content_${id}.json"
#  check_querycount
#  curl "${MARKETORESTURL}/landingpages/${id}/dynamicContent/${id}.json?access_token=${access_token}" -o ${MARKETODATADIR}/landingpages/${id}/dynamic_content_${id}.json -s
#  check_response "${MARKETODATADIR}/landingpages/${id}/dynamic_content_${id}.json"
done

echo "Done"

