#!/bin/bash

source ./vars.sh
source ./functions.sh


if [ $# -eq 0 ]
  then
    echo "Correct standalone script usage: get_landingpage_ <auth token> <id>"
    access_token=$(cat auth_token.json | awk -F'"' '{print $4}')
    id="6399"
    targetfilelocation=${MARKETODATADIR}/landingpages/${id}
  elif [ $# -eq 1 ]
    then
    access_token=$(cat auth_token.json | awk -F'"' '{print $4}')
    id=$1
    targetfilelocation=${MARKETODATADIR}/landingpages/${id}
  else
    access_token=$1
    id=$2
fi

if [ ${MARKETODEBUG} ] ; then
  echo "Retreiving landing page template data..."
fi
  mkdir -p ${targetfilelocation}
  echo ${targetfilelocation}
  if [ ${MARKETODEBUG} ] ; then
    echo " "
    echo "getting landing page template id ${id} ..."
  fi
  rm -f ${targetfilelocation}/landingpage_${id}.json
  curl ${CURLARGS} "${MARKETORESTURL}/landingPage/${id}.json?access_token=${access_token}" -o ${targetfilelocation}/landingpage_${id}.json
  check_response "${targetfilelocation}/landingpage_${id}.json"
  rm -f ${targetfilelocation}/content_${id}.json
  curl ${CURLARGS} "${MARKETORESTURL}/landingPage/${id}/content.json?access_token=${access_token}" -o ${targetfilelocation}/content_${id}.json
  check_response "${targetfilelocation}/content_${id}.json"
if [ ${MARKETODEBUG} ] ; then
  echo "Done"
fi
