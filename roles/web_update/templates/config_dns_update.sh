#! /bin/bash
#urlDomain="http://da.cisp.com"
urlDomain="http://{{new_dns}}/api/securitypolice/"

bak="index.js.bak"

source=`grep -o "index.*.js" index.html`

function file_replace()
{
#  sed -i "s#{{pe_dns}}#${urlDomain}#g" "$source"
  sed -i "s#commonConfigUrl_agKW8Ph6LXkreq5J#${urlDomain}#g" "$source"
}


if [ ! -f "$bak" ]; then
  cp "$source" "$bak"
else
  cp "$bak" "$source"
fi

file_replace || { echo "Conf failed."; exit 1;} 
