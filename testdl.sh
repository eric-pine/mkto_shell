#!/bin/bash
cat /root/logicnowlocalscripts/marketo/landingpageurls.txt | xargs -I % curl % >> /root/logicnowlocalscripts/marketo/curl_temp/landingpagehtml/allpages.html
