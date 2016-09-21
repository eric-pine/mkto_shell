This repository contains BASH scripts for some of the functions of the Marketo REST API. The purpose of the scripts are to provide programatic access to make batch changes to landing pages and other objects. Objects are downloaded into a data directory where they can be changed and the update scripts read them for updating Marketo. If the data is committed to git, it can provide a history and undo function for Marketo objects.

It makes use of curl to make queries and jq to query the resulting stored json files.

The location of the scripts and variables are stored in variables.sh. The scripts excute variables.sh, this script loads the variables into the envirnoment.



