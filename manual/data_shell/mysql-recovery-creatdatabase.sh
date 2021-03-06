#! /bin/bash
source /etc/profile    #加载系统环境变量
source ~/.bash_profile  #加载用户环境变量
set -o nounset       #引用未初始化变量时退出
set -o errexit      #执行shell命令遇到错误时退出
date_tar=$(date +%Y-%m-%d_%H-%M-%S)
date=$(date +%Y-%m-%d)
local_path=${PWD}
user="root"
#备份用户密码
password="baifendian"
#mysql连接端口
port="3306"
DB_HOST=`/sbin/ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d "addr:"`
mysql_path="/usr/local/mysql"
read -ep "请输入数据库备份文件的路径: " choose_path
if [ ! -d ${choose_path} ];then
	echo "请输入正确路径，已退出"
	exit
else
echo "以下为检测到的数据库文件名称："
cd ${choose_path}
for file in $(ls ${choose_path})
do
    [ -f ${file} ] && echo ${file%.*} && echo ${file%.*} >> ${local_path}/list.txt #先判断是否是目录，然后再输出
done
fi
cat_list=`cat ${local_path}/list.txt`
function recovery(){
        for dbname in ${cat_list};do
                sleep 1
                create_db="create database IF NOT EXISTS \`${dbname}\`"
                mysql -h$DB_HOST -P$port -u$user -p$password -e "${create_db}"
                mysql -h$DB_HOST -P$port -u$user -p$password -A $dbname < ${choose_path}/$dbname.sql
                 if [[ $? == 0 ]];then
                        echo "恢复时间:${date} 恢复方式:mysqldump 恢复数据库:$dbname 恢复状态:成功！" >> $local_path/recovery_${date}.log
                else
                        echo "恢复时间:${date} 恢复方式:mysqldump 恢复数据库:${dbname} 恢复状态:失败,请查看日志." >> $local_path/recovery_${date}.log

                fi
        done    


}

read -ep "全部恢复输入(A/a)，单个恢复输入(B/b):" choose
        if [ $choose = 'A' -o $choose = 'a' ];then
	recovery
	 elif [ $choose = 'B' -o $choose = 'b' ];then
	     read -ep "正在单个恢复数据库，请输入想要恢复的数据库名称:" mydatabase
             echo "正在恢复$mydatabase 请稍后....."
	     create_db="create database IF NOT EXISTS \`${mydatabase}\`"
	     mysql -h$DB_HOST -P$port -u$user -p$password -e "${create_db}"
             mysql -h$DB_HOST -P$port -u$user -p$password -A $mydatabase < $choose_path/$mydatabase.sql
             echo "$mydatabase 已成功恢复，恭喜！"
       	     exit			
			  
	else 
		echo "输入不符合规则，请重新执行..."
	     exit
	    fi	
