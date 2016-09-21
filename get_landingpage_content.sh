#!/bin/bash

source ./vars.sh

i=0
pauseafter=45
throttlewait=25

if [ $# -eq 0 ]
  then
    echo "Correct script usage: get_landingPages_content.sh <auth token>"
    access_token=$(cat auth_token.json | awk -F'"' '{print $4}')
  else
    access_token=$1
fi

echo "Retreiving landing page data..."

cat ${MARKETODATADIR}/landingpages.json | jq -r '.["result"][]["id"]' |\
while read id
do
  rm -rf ${MARKETODATADIR}/landingpages/${id}
  echo "getting landing page id ${id} request number $i ..."
  mkdir -p ${MARKETODATADIR}/landingpages/${id}
  echo "using request URL : ${MARKETORESTURL}/landingPage/${id}.json?access_token=${access_token}"
  curl "${MARKETORESTURL}/landingPage/${id}.json?access_token=${access_token}" -o ${MARKETODATADIR}/landingpages/${id}/landingpage_${id}.json -s
  if [ $(cat "${MARKETODATADIR}/landingpages/${id}/landingpage_${id}.json" | jq -r '.["success"]') = "true" ]
    then
      echo -e "\e[32mSUCCESS!\e[0m"
    else
      echo -e "\n\n\e[31mFailure!\e[0m\n\n"
      echo "Errors: $(cat "${MARKETODATADIR}/landingpages/${id}/landingpage_${id}.json" | jq -r '.["errors"]')"
  fi
  echo "using request URL : ${MARKETORESTURL}/landingPage/${id}/content.json?access_token=${access_token}"
  curl "${MARKETORESTURL}/landingPage/${id}/content.json?access_token=${access_token}" -o ${MARKETODATADIR}/landingpages/${id}/content_${id}.json -s
  if [ $(cat "${MARKETODATADIR}/landingpages/${id}/content_${id}.json" | jq -r '.["success"]') = "true" ]
    then
      echo -e "\e[32mSUCCESS!\e[0m"
    else
      echo -e "\n\n\e[31mFailure!\e[0m\n\n"
      echo "Errors: $(cat "${MARKETODATADIR}/landingpages/${id}/content_${id}.json" | jq -r '.["errors"]')"
  fi
  i=$[$i+1]
  if [ $i -eq "$pauseafter" ] ; then
    if [ ${MARKETODEBUG} ] ; then
      echo "Pausing $throttlewait seconds to not exceed max query limit..."
    fi
    sleep "$throttlewait"
    i=0
  fi
done

echo "Done"

