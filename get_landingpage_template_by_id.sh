#!/bin/bash

source ./vars.sh
source ./functions.sh

if [ $# -eq 0 ]
  then
    echo "Correct standalone script usage: get_landingpage_template_content.sh <auth token> <id>"
    access_token=$(cat auth_token.json | awk -F'"' '{print $4}')
    id="6399"
    targetfilelocation=${MARKETODATADIR}/landingpagetemplates/${id}
  else
    access_token=$1
    id=$2
fi

if [ ${MARKETODEBUG} ] ; then
  echo "Retreiving landing page template data..."
fi

  whendebug "echo "getting landing page template id ${id} ...""
  mkdir -p ${targetfilelocation}
  if [ ${MARKETODEBUG} ] ; then
    echo "using request URL : https://${MARKETORESTURL}/landingPageTemplate/${id}.json?access_token=${access_token}"
  fi
  rm -f ${targetfilelocation}/landingpagetemplate_${id}.json
  curl "${MARKETORESTURL}/landingPageTemplate/${id}.json?access_token=${access_token}" -o ${targetfilelocation}/landingpagetemplate_${id}.json
  check_response "${targetfilelocation}/landingpagetemplate_${id}.json"
  if [ ${MARKETODEBUG} ] ; then
    echo "using request URL : ${MARKETORESTURL}/landingPageTemplate/${id}/content.json?access_token=${access_token}"
  fi
  rm -f -o ${targetfilelocation}/contenttemplate_${id}.json
  curl "${MARKETORESTURL}/landingPageTemplate/${id}/content.json?access_token=${access_token}" -o ${targetfilelocation}/contenttemplate_${id}.json
  check_response "${targetfilelocation}/contenttemplate_${id}.json"
if [ ${MARKETODEBUG} ] ; then
  echo "Done"
fi
