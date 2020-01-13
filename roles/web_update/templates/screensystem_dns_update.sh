#! /bin/bash
bak="index.js.bak"

source=`grep -o "index.*.js" index.html`

function file_replace()
{

  sed -i "s#{{pe_screenmanager_dns}}#{{new_screenmanager_dns}}#g" "$source"
  sed -i "s#{{ke_screenmanager_dns}}#{{new_screenmanager_dns}}#g" "$source"
  sed -i "s#{{pe_dns}}#{{new_dns}}#g" "$source"
  sed -i "s#{{ke_dns}}#{{new_dns}}#g" "$source"

}


if [ ! -f "$bak" ]; then
  cp "$source" "$bak"
else
  cp "$bak" "$source"
fi

file_replace || { echo "Conf failed."; exit 1;} 
