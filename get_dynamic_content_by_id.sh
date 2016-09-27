#!/bin/bash
source ./vars.sh
source ./functions.sh

access_token=$(cat auth_token.json | awk -F'"' '{print $4}')
id=6399
contentid=mktSidebar
queryurl=${MARKETORESTURL}/landingPage/${id}/dynamicContent/${contentid}.json?access_token=${access_token}
outputfile=${MARKETODATADIR}/landingpages/${id}/dynamic_content_${id}.json

if [ $# -eq 3 ] ; then
auth_token=$1
id=$2
contentid=$3
fi

if [ $# -eq 2 ] ; then
id=$1
contentid=$2
fi


if [ ${MARKETODEBUG} ] ; then
  echo " "
  echo "Retrieving page ${id} section ${sectionid} ..."
fi

rm -f ${outputfile}
curl ${CURLARGS} ${queryurl} -o ${outputfile}
check_response "${outputfile}"

