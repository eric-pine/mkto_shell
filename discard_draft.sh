#!/bin/bash
source ./vars.sh

# usage: discard_draft.sh [authorization token] <landing page id>

if [ ${MARKETODEBUG} ] ; then
  echo -e "\n\ncommand: $0 \n\n"
  echo -e "arguments: $@ \n\n\n"
fi

if [ $# -eq 0 ]
  then
    echo -e "\n\nCorrect script usage: discard_draft.sh [auth token] <template id>\n\n"
    exit 1
  elif [ $# -eq 1 ]
    then
    access_token=$(cat auth_token.json | awk -F'"' '{print $4}')
    id=$1
  else
    access_token=$1
    id=$2
fi



curl "${MARKETORESTURL}/landingPage/${id}/discardDraft.json?access_token=${access_token}" -o ${MARKETOUPDATERESPONSE} -s -v


