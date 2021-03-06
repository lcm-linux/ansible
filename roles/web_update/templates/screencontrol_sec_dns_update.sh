#! /bin/bash
bak="index.js.bak"

source=`grep -o "index.*.js" index.html`


function file_replace()
{

  sed -i "s#{{pe_screencontrol_sec_dns}}#{{new_screencontrol_sec_dns}}#g" "$source"
  sed -i "s#{{ke_screencontrol_sec_dns}}#{{new_screencontrol_sec_dns}}#g" "$source"
  sed -i "s#{{pe_dns}}#{{new_dns}}#g" "$source"
  sed -i "s#{{ke_dns}}#{{new_dns}}#g" "$source"
  sed -i "s#{{pe_integratedpolice_dns}}#{{new_integratedpolice_dns}}#g" "$source"
  sed -i "s#{{ke_integratedpolice_dns}}#{{new_integratedpolice_dns}}#g" "$source"

}


if [ ! -f "$bak" ]; then
  cp "$source" "$bak"
else
  cp "$bak" "$source"
fi

file_replace || { echo "Conf failed."; exit 1;} 
