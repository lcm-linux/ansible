#/bin/bash
cat_list=`cat list.txt`
for f in $cat_list
do
	sed -i 's#{{web_path}}#{{web_path}}#g' $f
	sed -i 's#{{nginx_begin}}#{{nginx_begin}}#g' $f
	sed -i 's#{{nginx_mid}}#{{nginx_mid}}#g' $f
	sed -i 's#{{nginx_mid}}#{{nginx_mid}}#g' $f
	sed -i 's#{{nginx_end}}#{{nginx_end}}#g' $f
	sed -i 's#{{nginx_end}}#{{nginx_end}}#g' $f
done
