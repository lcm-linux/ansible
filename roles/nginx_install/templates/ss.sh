#!/bin/bash
path=/etc/ansible/roles/nginx_install/templates
ls_path=`ls $path`
for f in $ls_path
do
    [ -f ${f} ] && echo ${f} >> list.txt
done
