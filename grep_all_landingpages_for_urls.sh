#!/bin/bash
cat ./landingpageurls.txt | xargs -I % curl -s % | grep -o 'http://[^"]*' | grep -v logicnow.com | grep -v maxfocus.com | grep -v controlnow.com > http_urls_on_pages.txt
sort http_urls_on_pages.txt | uniq -u > unique_urls.txt


