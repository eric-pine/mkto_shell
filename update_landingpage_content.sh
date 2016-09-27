#!/bin/bash
source ./vars.sh
source ./functions.sh

correctusage="$0 [auth token] <template id>"

if [ $# -eq 0 ]
  then
    echo ' '
    echo ' '
    echo "Correct script usage: update_landingpage_content.sh <auth token> <template id>"
    access_token=$(cat auth_token.json | awk -F'"' '{print $4}')
    id="6399"
  else
    access_token=$1
    id=$2
fi

if [ ${MARKETODEBUG} ] ; then
  echo " "
  echo "updating page template id ${id} ..."
fi

#if [ ${MARKETODEBUG} ] ; then
#  echo "cat ${MARKETODATADIR}/landingpagetemplates/${id}/contenttemplate_${id}.json | jq -r '.["result"][]["content"]'"
# echo "using request URL : ${MARKETORESTURL}/landingPageTemplate/${id}/content.json?access_token=${access_token}"
#fi

sectionids=$(cat ./marketo_data/landingpages/6399/content_6399.json | jq -r '.result[]["id"]' | grep -v form)
#sectionids=$(cat ${MARKETODATADIR}/landingpages/${id}/content_${id}.json | jq -r '.[0] | {id: .[][]["id"], content: .[][]["content"]')
#content=$(echo \'&content=\'$(cat ${MARKETODATADIR}/landingpagetemplates/${id}/contenttemplate_${id}.json | jq -r '.["result"][]["content"]')\'\')
#content=$(echo content=$(cat ${MARKETODATADIR}/landingpagetemplates/${id}/contenttemplate_${id}.json | jq -r '.["result"][]["content"]'))
#content=$(cat ${MARKETODATADIR}/landingpagetemplates/${id}/landingpagetemplate_${id}.json | jq -r '.["result"][]["content"]')
for sectionid in $sectionids
do
  echo "Calling update for $sectionid"
  content=$(cat ${MARKETODATADIR}/landingpages/${id}/content_${id}.json | jq -r '.[][]["content"]')
  body="id=${id}&contentId=${sectionid}&Type=RichText&value=${content}"
  echo -e "\n" >> ${MARKETOUPDATERESPONSE}
  #echo "using curl command echo \"${content}\" | curl  -X POST -d @- ${MARKETORESTURL}/landingPageTemplate/${id}/content.json?access_token=${access_token}"
  echo ${body} | curl -d @- ${MARKETORESTURL}/landingPage/${id}/${sectionid}.json?access_token=${access_token} >> ${MARKETOUPDATERESPONSE}
check_response
done

