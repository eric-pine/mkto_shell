#!/bin/bash
./get_pages_json.sh
echo "Listing landing page urls"
cat landingPages.json | grep -o 'http.://[^"]*' | grep html > landingpageurls.txt
sed -i 's/https:\/\/app-ab13.marketo.com/http:\/\/pages.logicnow.com/g' landingpageurls.txt

