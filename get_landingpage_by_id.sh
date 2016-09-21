#!/bin/bash

access_token_var=
id_var=$1
status_var=$2

echo "https://356-UVH-403.mktorest.com/rest/asset/v1/landingPage/"$id_var"/content.json?access_token="$access_token_var"&status="$status_var""
curl "https://356-UVH-403.mktorest.com/rest/asset/v1/landingPage/"$id_var"/content.json?access_token="$access_token_var"&status="$status_var""
