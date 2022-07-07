#!/bin/bash

echo "Performing robot curl."
echo "Please enter list of url (split by comma for multiple site)"

read input
sites=(${input//,/ })

echo ""
echo "Url entered ${#sites[@]} url(s):"
echo $'\e[1;33m'$input$'\e[0m'
echo ""

for i in ${!sites[@]}; do
  echo "Run for ${sites[i]}:"
  curl --compressed -H "Range: bytes=0-524288" -H "Cache-Control: no-cache" -H "Connection: close" -A "facebookexternalhit/1.1" ${sites[i]}
  echo ""
done
