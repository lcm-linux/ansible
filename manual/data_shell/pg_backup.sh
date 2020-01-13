#!/bin/bash
### -------注意，此脚本需要先切换到postgres用户下进行操作---------------

source ~/.bash_profile  #加载用户环境变量
set -o nounset       #引用未初始化变量时退出
set -o errexit      #执行shell命令遇到错误时退出

BACK_PATH="/opt/postgresql/backup" #设置备份路劲
day=1    #设置保留备份保留的天数。
user="postgres"  #备份用户

#判断备份文件夹是否存在，不存在则创建。
if [ ! -e $BACK_PATH ];then
mkdir -p $BACK_PATH
#chown -R postgres.postgres $BACK_PATH
fi

BACK_LOG="$BACK_PATH/pg_back_`date +%Y%m%d`.log"
#touch $BACK_LOG
#chown -R postgres.postgres $BACK_LOG

echo "START BACKUP..............." > $BACK_LOG

cd $BACK_PATH
for i in $(psql -c "\l"|grep -v "List"|grep -v "Encoding"|grep -v "\-\-\-\-"|awk '{print $1}'|grep  -v "|" |grep -v "("|grep -v template|grep -v postgres)
do 
sleep 1

pg_dump  -U $user  $i   >${i}.sql
echo "create database \"$i\" ;" >>create_databases.sql
if [[ $? == 0 ]];then
   
    size=$(du $BACK_PATH/${i}.sql -sh | awk '{print $1}')
    echo "备份时间:`date +%Y-%m-%d-%H:%M:%S`  备份方式:psqldump 备份数据库:$i($size) 备份状态:成功！" >>$BACK_LOG
  else
    
    echo "备份时间:`date +%Y-%m-%d-%H:%M:%S` 备份方式:psqldump 备份数据库:${i} 备份状态:失败,请查看日志." >>$BACK_LOG
  fi
done
echo "---------所有数据库已备份完成，正在打成压缩包-----------" >>$BACK_LOG
echo "---------所有数据库已备份完成，正在打成压缩包-----------"

tar -zcf pg_backup_all_`date +%Y%m%d`.tar.gz *.sql
rm -rf $BACK_PATH/*.sql

du  -sh pg_backup_all_`date +%Y%m%d`*.tar.gz  | awk '{print "备份文件:" $2 ",大小:" $1}' >>$BACK_LOG

find $BACK_PATH  -type f -mtime +$day -exec rm -rf {} \; > /dev/null 2>&1 

echo "==========All databases backups over==========" >>$BACK_LOG
echo "BACKUP  END" >> $BACK_LOG

