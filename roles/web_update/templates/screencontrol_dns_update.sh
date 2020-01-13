#! /bin/bash
#urlDomain="http://da.cisp.com"
#urlDomain="{{new_dns}}"
#url_screen_pe="{{pe_screencontrol_dns}}"
#url_screen_ke="{{ke_screencontrol_dns}}"
#url_screen_new="{{new_screencontrol_dns}}"
bak="index.js.bak"

source=`grep -o "index.*.js" index.html`


function file_replace()
{

  sed -i "s#{{pe_screencontrol_dns}}#{{new_screencontrol_dns}}#g" "$source"
  sed -i "s#{{ke_screencontrol_dns}}#{{new_screencontrol_dns}}#g" "$source"
  sed -i "s#{{pe_dns}}#{{new_dns}}#g" "$source"
  sed -i "s#{{ke_dns}}#{{new_dns}}#g" "$source"

}


if [ ! -f "$bak" ]; then
  cp "$source" "$bak"
else
  cp "$bak" "$source"
fi

file_replace || { echo "Conf failed."; exit 1;} 
