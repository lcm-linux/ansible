#! /bin/bash
urlDomain="http://{{new_dns}}"

bak="app.js.bak"

source=`find app.js`

function file_replace()
{
  sed -i "s#urlDomain_agKW8Ph6LXkreq5J#${urlDomain}#g" "$source"
}


if [ ! -f "$bak" ]; then
  cp "$source" "$bak"
else
  cp "$bak" "$source"
fi

file_replace || { echo "Conf failed."; exit 1; }
