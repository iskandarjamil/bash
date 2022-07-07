#!/bin/bash

echo "Performing network testing."
echo "Please enter list of url (split by comma for multiple site)"

read input
sites=(${input//,/ })

echo ""
echo "Url entered ${#sites[@]} url(s):"
echo $'\e[1;33m'$input$'\e[0m'
echo ""

for i in ${!sites[@]}; do
  echo "Run for ${sites[i]}:"
  curl -o /dev/null -H 'Cache-Control: no-cache' -s -w "Connect: %{time_connect} TTFB: %{time_starttransfer} Total time: %{time_total} \n" ${sites[i]}
  echo ""
done
