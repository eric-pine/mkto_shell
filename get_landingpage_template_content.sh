#!/bin/bash

source ./vars.sh

i=0
pauseafter=45
throttlewait=25

if [ $# -eq 0 ]
  then
    echo "Correct standalone script usage: get_landingpage_template_content.sh <auth token> <input file>"
    access_token=$(cat auth_token.json | awk -F'"' '{print $4}')
    input_file="landingpagetemplates.json"
  else
    access_token=$1
    input_file=$2
fi

if [ ${MARKETODEBUG} ] ; then
  echo "Retreiving landing page template data..."
fi

cat ${MARKETODATADIR}/${input_file} | jq -r '.["result"][]["id"]' |\

while read id
do
  rm -rf ${MARKETODATADIR}/landingpagetemplates/${id}
  if [ ${MARKETODEBUG} ] ; then
    echo " "
    echo "getting landing page template id ${id} request number $i ..."
  fi
  mkdir -p ${MARKETODATADIR}/landingpagetemplates/${id}
  if [ ${MARKETODEBUG} ] ; then
    echo "using request URL : https://${MARKETORESTURL}/landingPageTemplate/${id}.json?access_token=${access_token}"
  fi
  curl "${MARKETORESTURL}/landingPageTemplate/${id}.json?access_token=${access_token}" -o ${MARKETODATADIR}/landingpagetemplates/${id}/landingpagetemplate_${id}.json -s
  if [ $(cat "${MARKETODATADIR}/landingpagetemplates/${id}/landingpagetemplate_${id}.json" | jq -r '.["success"]') = "true" ]
    then
      echo -e "\e[32mSUCCESS!\e[0m"
    else
      echo -e "\n\n\e[31mFailure!\e[0m\n\n"
      echo "Errors: $(cat "${MARKETODATADIR}/landingpagetemplates/${id}/landingpagetemplate_${id}.json" | jq -r '.["errors"]')"
  fi

  if [ ${MARKETODEBUG} ] ; then
    echo "using request URL : ${MARKETORESTURL}/landingPageTemplate/${id}/content.json?access_token=${access_token}"
  fi
  curl "${MARKETORESTURL}/landingPageTemplate/${id}/content.json?access_token=${access_token}" -o ${MARKETODATADIR}/landingpagetemplates/${id}/contenttemplate_${id}.json -s
  if [ $(cat "${MARKETODATADIR}/landingpagetemplates/${id}/contenttemplate_${id}.json" | jq -r '.["success"]') = "true" ]
    then
      echo -e "\e[32mSUCCESS!\e[0m"
    else
      echo -e "\n\n\e[31mFailure!\e[0m\n\n"
      echo "Errors: $(cat "${MARKETODATADIR}/landingpagetemplates/${id}/contenttemplate_${id}.json" | jq -r '.["errors"]')"
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

if [ ${MARKETODEBUG} ] ; then
  echo "Done"
fi
