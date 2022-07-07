#!/bin/bash

SCRIPT=$( basename "$0" )
VERSION="1.0.0"
URL=""

echo "Performing network testing."

#
# Message to display for usage and help.
#
function usage
{
    local txt=(
"Usage: $SCRIPT --url https://example.com"
""
"Options:"
"  --url          List of urls split by comma."
"  --help, -h     Print help."
"  --version, -v  Print version."
    )

    printf "%s\n" "${txt[@]}"
}

#
# Message to display for version.
#
function version
{
    local txt=(
"$SCRIPT version $VERSION"
    )

    printf "%s\n" "${txt[@]}"
}

function join { local IFS="$1"; shift; echo "$*"; }

#
# Process options
#
for i in $#; do
    case "$1" in

        --help | -h)
            usage
            exit 0
        ;;

        --version | -v)
            version
            exit 0
        ;;

        --url)
            URL=$2
            break
        ;;

    esac
done

if [[ $URL == "" ]]; then
  echo "Please enter list of url (split by comma for multiple site)"
  read input
  sites=(${input//,/ })
else
  sites=(${URL//,/ })
fi

text=$(join , ${sites[@]})
echo ""
echo "Url entered ${#sites[@]} url(s):"
echo $'\e[1;33m'$text$'\e[0m'
echo ""

for i in ${!sites[@]}; do
  echo "Run for ${sites[i]}:"
  curl -o /dev/null -H 'Cache-Control: no-cache' -s -w "Connect: %{time_connect} TTFB: %{time_starttransfer} Total time: %{time_total} \n" ${sites[i]}
  echo ""
done
