#!/bin/bash

# URL: <REST API Endpoint URL>/rest/asset/v1/landingPageTemplate/{id}/content.json

source ./vars.sh

if [ ${MARKETODEBUG} ] ; then
  echo -e "\n\ncommand: $0 \n\n"
  echo -e "arguments: $@ \n\n\n"
fi

if [ $# -eq 0 ]
  then
    echo ' '
    echo ' '
    echo "Correct script usage: update_landingpage_template_content.sh <auth token> <template id>"
    access_token=$(cat auth_token.json | awk -F'"' '{print $4}')
    id="1639"
  else
    access_token=$1
    id=$2
fi

if [ ${MARKETODEBUG} ] ; then
  echo " "
  echo "updating page template id ${id} ..."
fi

if [ ${MARKETODEBUG} ] ; then
  echo "cat ${MARKETODATADIR}/landingpagetemplates/${id}/contenttemplate_${id}.json | jq -r '.["result"][]["content"]'"
  echo "using request URL : ${MARKETORESTURL}/landingPageTemplate/${id}/content.json?access_token=${access_token}"
fi

#content=$(echo \'&content=\'$(cat ${MARKETODATADIR}/landingpagetemplates/${id}/contenttemplate_${id}.json | jq -r '.["result"][]["content"]')\'\')
#content=$(echo content=$(cat ${MARKETODATADIR}/landingpagetemplates/${id}/contenttemplate_${id}.json | jq -r '.["result"][]["content"]'))
#content=$(cat ${MARKETODATADIR}/landingpagetemplates/${id}/landingpagetemplate_${id}.json | jq -r '.["result"][]["content"]')
content=$(cat ${MARKETODATADIR}/landingpagetemplates/${id}/contenttemplate_${id}.json | jq -r '.[][]["content"]')
#content='&id="1042"&description="This is a duplicate and should not be used going forward.-test"'
#echo " "
#echo " "
#echo $content
#echo " "
#echo " "
echo -e "\n" >> ${MARKETOUPDATERESPONSE}
echo "using curl command echo \"${content}\" | curl  -X POST -d @- ${MARKETORESTURL}/landingPageTemplate/${id}/content.json?access_token=${access_token}"
echo "${content}" | curl -F "content=@-;Type=text/html; charset=UTF-8" ${MARKETORESTURL}/landingPageTemplate/${id}/content.json?access_token=${access_token} >> ${MARKETOUPDATERESPONSE}

if [ $(cat "${MARKETOUPDATERESPONSE}" | jq '.["success"]' | tail -n 1 ) = "true" ] 
  then 
    echo -e "\e[32mSUCCESS!\e[0m"
  else 
    echo -e "\n\n\e[31mFailure!\e[0m\n\n" 
    echo "Errors: $(cat "${MARKETOUPDATERESPONSE}" | jq -r '.["errors"]')"
fi
