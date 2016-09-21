#!/bin/bash

source ./vars.sh

if [ $# -eq 0 ]
  then
    echo "Correct standalone script usage: get_landingpage_template_content.sh <auth token> <id>"
    access_token=$(cat auth_token.json | awk -F'"' '{print $4}')
    id="1042"
  else
    access_token=$1
    id=$2
fi

if [ ${MARKETODEBUG} ] ; then
  echo "Retreiving landing page template data..."
fi

  if [ ${MARKETODEBUG} ] ; then
    echo " "
    echo "getting landing page template id ${id} ..."
  fi
  if [ ${MARKETODEBUG} ] ; then
    echo "using request URL : https://${MARKETORESTURL}/landingPageTemplate/${id}.json?access_token=${access_token}"
  fi
  curl "${MARKETORESTURL}/landingPageTemplate/${id}.json?access_token=${access_token}" 
  if [ ${MARKETODEBUG} ] ; then
    echo "using request URL : ${MARKETORESTURL}/landingPageTemplate/${id}/content.json?access_token=${access_token}"
  fi
  curl "${MARKETORESTURL}/landingPageTemplate/${id}/content.json?access_token=${access_token}" 

if [ ${MARKETODEBUG} ] ; then
  echo "Done"
fi
