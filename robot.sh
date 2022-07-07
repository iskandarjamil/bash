#!/bin/bash
echo "Performing robot curl."

SCRIPT=$( basename "$0" )
VERSION="1.0.0"

header=false
robots_name=('Googlebot Desktop' 'Googlebot Smartphone' 'Facebook')
robots=('Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)' 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/W.X.Y.Z Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)' 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)')

#
# Message to display for usage and help.
#
function usage
{
    local txt=(
"Usage: $SCRIPT [options]"
""
"Options:"
"  --header, -h   Header only."
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

#
# Process options
#
while (( $# ))
do
    case "$1" in

        --help | -h)
            usage
            exit 0
        ;;

        --version | -v)
            version
            exit 0
        ;;

        --header | -I)
            header=true
            break
        ;;

    esac
done

echo "Please select robot user agent:"
for i in ${!robots[@]}; do
  echo "  $((i+1))) ${robots_name[i]}"
done
read robot

echo "Selected robot:"
echo $'\e[1;33m'${robots[$((robot-1))]}$'\e[0m'
echo ""

echo "Please enter list of url (split by comma for multiple site)"
read input
sites=(${input//,/ })

echo ""
echo "Url entered ${#sites[@]} url(s):"
echo $'\e[1;33m'$input$'\e[0m'
echo ""

for i in ${!sites[@]}; do
  echo "Run for ${sites[i]}:"
  if [[ ${header} == true ]]; then
    curl --compressed -H "Range: bytes=0-524288" -H "Cache-Control: no-cache" -H "Connection: close" -A "${robots[$((robot-1))]}" ${sites[i]} -I
  else
    curl --compressed -H "Range: bytes=0-524288" -H "Cache-Control: no-cache" -H "Connection: close" -A "${robots[$((robot-1))]}" ${sites[i]}
  fi
  echo ""
done
