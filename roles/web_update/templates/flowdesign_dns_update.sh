#! /bin/bash
#urlDomain="http://da.cisp.com"
urlDomain="{{new_dns}}"

bak="index.js.bak"

source=`grep -o "index.*.js" index.html`

function file_replace()
{
  sed -i "s#{{pe_dns}}#${urlDomain}#g" "$source"
  sed -i "s#{{ke_dns}}#${urlDomain}#g" "$source"
}


if [ ! -f "$bak" ]; then
  cp "$source" "$bak"
else
  cp "$bak" "$source"
fi

file_replace || { echo "Conf failed."; exit 1;} 
