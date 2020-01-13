#!/bin/bash

#全备方式
#作者：lichunmiao
#时间：2019.08.06
#此导入脚本要结合导出脚本es_export.sh产生的es列表list.txt来一起使用，最好将两个脚本放在同一个目录下
source /etc/profile    #加载系统环境变量
source ~/.bash_profile  #加载用户环境变量
set -o nounset       #引用未初始化变量时退出
set -o errexit      #执行shell命令遇到错误时退出
#recovery_path="/data1/es_data/es_rec"
date=$(date +%Y-%m-%d_%H-%M-%S)
#export_ip="192.168.40.111"
#export_port="9200"
#recovery_log="${2}/es_import_${date}.log"

#===============开始导入数据=======================
#echo "导入开始,结果查看 $recovery_log"
#============检查是否存在elasticdump命令=================
#command -v elasticdump >/dev/null 2>&1 || { echo >&2 "环境中没有检测到elasticdump，请确认是否存在，备份已中止！"; exit 1; }


function download(){
        while read line
        do
             elasticdump  --input=${1}/${line}_settings.json --output=http://${2}/${line} --type=settings --searchBody '{"query": { "match_all": {} }, "stored_fields": ["*"],"_source": true }' 
                sleep 5
             elasticdump  --input=${1}/${line}_analyzer.json --output=http://${2}/${line} --type=analyzer --searchBody '{"query": { "match_all": {} }, "stored_fields": ["*"],"_source": true }' 
                sleep 5
             elasticdump  --input=${1}/${line}_mapping.json --output=http://${2}/${line} --type=mapping --searchBody '{"query": { "match_all": {} }, "stored_fields": ["*"],"_source": true }' 
                sleep 5
             elasticdump --input=${1}/${line}_data.json --output=http://${2}/${line} --type=data --searchBody '{"query": { "match_all": {} }, "stored_fields": ["*"],"_source": true }' 
        done < list.txt
}


function check(){

        if [ `npm ls elasticdump >/dev/null && echo $?` != 0 ];then
                npm install elasticdump
                cp /node_modules/elasticdump/bin/elasticdump /usr/sbin/
                echo "elasticdump 安装完成..."
        else
                echo "elasticdump 已经正常安装！！"
        fi
}


read -p "确定elasticdump是否正确安装?(y/n):" judge
if [ $judge = 'y' -o $judge = 'Y' ];then
        read -p "请输入es的数据存储的位置 ： " floder
        read -p "请输入es集群的IP和端口，eg:172.16.3.139:9200 ： " IPinfo
#        echo "开始导入...结果查看 $recovery_log"

        download ${floder} ${IPinfo}

else
        echo "检查安装并且开始下载任务"
        check
        read -p "请输入es的数据存储的位置 ： " floder
    	read -p "请输入es集群的IP和端口，eg:172.16.3.139:9200 ： " IPinfo
#        echo "开始导入...结果查看 $recovery_log"
        download ${floder} ${IPinfo}
fi

