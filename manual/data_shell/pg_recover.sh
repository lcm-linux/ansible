#!/bin/bash
pg_recover_user='postgres' #制定备份恢复用户


mkdir /tmp/pg_recpver
tar zxf $1 -C /tmp/pg_recpver
psql -U $pg_recover_user   -f /tmp/pg_recpver/create_databases.sql
rm -rf /tmp/pg_recpver/create_databases.sql

 echo "【`date +%Y-%m-%d-%H:%M:%S`】  ==========START RECOVER==========" >>RECOVER.log
for i in `ls /tmp/pg_recpver`
do
psql -U $pg_recover_user -d `echo $i | cut -d "." -f 1`  -f $i
if [[ $?==0 ]] ;then

echo -e " 时间:`date +%Y-%m-%d-%H:%M:%S` 数据库:$i 恢复成功！！！！！！ " >>RECOVER.log
else
echo -e " 时间:`date +%Y-%m-%d-%H:%M:%S` 数据库:$i 恢复失败！！！！！！ " >>RECOVER.log

fi

rm  /tmp/pg_recpver/$i
done

echo "【`date +%Y-%m-%d-%H:%M:%S`】  ==========RECOVER ENDING==========" >>RECOVER.log


