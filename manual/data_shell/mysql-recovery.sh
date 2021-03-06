#! /bin/bash
source /etc/profile    #加载系统环境变量
source ~/.bash_profile  #加载用户环境变量
set -o nounset       #引用未初始化变量时退出
set -o errexit      #执行shell命令遇到错误时退出
user="root"
#备份用户密码
password="123456"
#mysql连接端口
port="3306"
DB_HOST=`/sbin/ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d "addr:"`
mysql_path="/usr/local/mysql"
date=$(date +%Y-%m-%d_%H-%M-%S)
#备份路径---需要修改
#recovery_path="/opt/mysql_backup/new-bak"
#recovery_log="${recovery_path}/mysqldump_recovery_${date}.log"
mysql_list=`mysql -h$DB_HOST -P$port -u$user -p$password -A -e "show databases\G"|grep Database|grep -v schema|grep -v test|awk '{print $2}'`
echo "数据库名称列表如下:"
echo "${mysql_list}"

read -p "全部恢复输入(A/a)，单个恢复输入(B/b):" choose
#echo $choose
#	if [ $choose = 'A' -o $choose = 'a' -o $choose != 'B' -o $choose != 'b' ];then
        if [ $choose = 'A' -o $choose = 'a' ];then
	read -p "正在准备恢复全部数据库，请输入恢复数据文件所在路径:" allpath
		if [ ! -d $allpath ];then
			echo "此路径不存在，请重新执行..."
			exit				
		fi
	for dbname in ${mysql_list};do
		sleep 1
		create_db="create database IF NOT EXISTS ${dbname}"
		mysql -h$DB_HOST -P$port -u$user -p$password -e "${create_db}"
		mysql -h$DB_HOST -P$port -u$user -p$password -A $dbname < $allpath/$dbname.sql
		 if [[ $? == 0 ]];then
			cd $allpath
    			size=$(du $allpath/$dbname.sql -sh | awk '{print $1}')
    			echo "恢复时间:${date} 恢复方式:mysql 恢复数据库:$dbname($size) 恢复状态:成功！" >> $allpath/recovery_${date}.log
  		else
    			cd $allpath
    			echo "恢复时间:${date} 恢复方式:mysqldump 恢复数据库:${dbname} 恢复状态:失败,请查看日志." >> $allpath/recovery_${date}.log

		fi
	done	
	 elif [ $choose = 'B' -o $choose = 'b' ];then
	     read -p -e "正在单个恢复数据库，请输入想要恢复的数据库名称:" mydatabase
	     read -p -e "请输入数据库恢复的路径:" mypath
		if [ ! -d $mypath ];then
        		echo "此路径不存在，请重新执行..."
       		 	exit
		elif [ ! -f $mypath/$mydatabase.sql ];then
			echo "此路径下没有目标数据库文件,请重新执行..."
			exit
		     elif [ $mydatabase != $mysql_list ];then
                                echo "$mydatabase 不在此数据库中，请确认数据库名称后再试，再见！"
			  else
                                echo "正在恢复$mydatabase 请稍后....."
								create_db="create database IF NOT EXISTS ${dbname}"
								mysql -h$DB_HOST -P$port -u$user -p$password -e "${create_db}"
                                mysql -h$DB_HOST -P$port -u$user -p$password -A $mydatabase < $mypath/$mydatabase.sql
                                echo "$mydatabase 已成功恢复，恭喜！"
       			 	exit			
			  fi
#		     fi
#		fi
#	     fi
	else 
#	    if [ $choose != 'B' -o $choose != 'b' -o $choose != 'A' -o $choose != 'a' ];then 
		echo "输入不符合规则，请重新执行..."
	     exit
	    fi
	
