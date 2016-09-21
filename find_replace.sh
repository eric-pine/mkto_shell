#!/bin/bash

source ./vars.sh

if [ $# -eq 0 ]
  then
    echo "Correct script usage: find_replace.sh <filename> <string to replace using sed> <replacement string>"
  else
filename=$1
find=$2
replace=$3
fi

sed -i -e "s/${find}/${replace}/g" ${filename}
