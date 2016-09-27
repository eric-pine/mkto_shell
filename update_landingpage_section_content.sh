#!/bin/bash
source ./vars.sh
source ./functions.sh

access_token=$(cat auth_token.json | awk -F'"' '{print $4}')
id=6399
contentid=mktContent

correctusage="$0 [auth token] <template id> <section id>"

when_debug "execution_info $# $@"

#no_args_display $#

if [ $# -eq 1 ]
  then
  no_args_display
fi

if [ $# -eq 2 ]
  then
  id=$1
  contentid=$2
fi

if [ $# -eq 3 ]
  then
  access_token=$1
  id=$2
  contentid=$3
fi

when_debug "echo -e \n\nUpdating landing page content section id \"${contentid}\" ...\n\n"

content=$(cat ${MARKETODATADIR}/landingpages/${id}/content_${id}.json | jq -r ".result[] | select(.id==\""${contentid}"\") | .content")
#contenttype=$(cat ${MARKETODATADIR}/landingpages/${id}/content_${id}.json | jq -r ".result[] | select(.id==\""${contentid}"\") | .type")

when_debug "echo -e sending section content: ${content} \n\n"

echo -e "\n" >> ${MARKETOUPDATERESPONSE}
#when_debug "\"echo ${content} | curl -F "content=@-;Type=text/html; charset=UTF-8" ${MARKETORESTURL}/landingPage/${id}/content/${contentid}.json?access_token=${access_token} >> ${MARKETOUPDATERESPONSE}\""
#echo "${content}" | curl ${CURLARGS}  --form-string "type=\"html\"; content=@-; id=${contentid}; charset=UTF-8" ${MARKETORESTURL}/landingPage/${id}/content/${contentid}.json?access_token=${access_token} >> ${MARKETOUPDATERESPONSE}
#echo "${content}"
body="id=${id}&ContentId=${contentid}&type="text"&value=\"${content}\""
#echo "body: "${body} > test
echo ${body} | curl ${CURLARGS} -X POST -d @- "${MARKETORESTURL}/landingPage/${id}/content/${contentid}.json?access_token=${access_token}" >> ${MARKETOUPDATERESPONSE}

check_response "${MARKETOUPDATERESPONSE}"
