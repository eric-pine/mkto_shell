#!/bin/bash
source ./vars.sh
source ./functions.sh

# usage: approve_draft.sh [authorization token] <landing page id>
correctusage="$0 [auth token] <template id>"

when_debug "execution_info $# $@"

no_args_display $#

if [ $# -eq 1 ]
  then
    access_token=$(cat auth_token.json | awk -F'"' '{print $4}')
    id=$1
  else
    access_token=$1
    id=$2
fi



curl "${MARKETORESTURL}/landingPage/${id}/approveDraft.json?access_token=${access_token}" -o ${MARKETOUPDATERESPONSE} -s -v


