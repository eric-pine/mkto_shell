#!/bin/bash
source ./vars.sh
source ./functions.sh

access_token=$(cat auth_token.json | awk -F'"' '{print $4}')
id=6511
contentid=mktContent
queryurl=${MARKETORESTURL}/landingPage/${id}/content/${contentid}/delete.json?access_token=${access_token}
outputfile=${MARKETOUPDATERESPONSE}

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
curl ${CURLARGS} -X POST ${queryurl} >> ${outputfile}
check_response "${outputfile}"

