#!/bin/bash
function import(){
    while read line
        do s3cmd mb s3://${line}
    done < bucket_list.txt
    array=`s3cmd ls  | cut -d "/" -f 3`
    cd ${1}
    for element in ${array[@]}
        do
          s3cmd put ${element}/*  s3://${element}/
          echo "bucket ${element} 导入完成"
        done

    sleep 5
}

function check(){

        if [ `rpm -qa|grep s3cmd >/dev/null && echo $?` != 0 ];then
                yum install s3cmd
                echo "s3cmd 安装完成..."
        else
                echo "s3cmd 已经正常安装！！"
        fi
}

read -p "确定s3cmd是否正确安装?(y/n):" judge
if [ $judge = 'y' -o $judge = 'Y' ];then
        read -p "请输入ceph数据存储的位置 ： " floder
        echo "开始导入..."

        import ${floder}

else
        echo "检查安装"
        check
        read -p "请输入ceph数据存储的位置 ： " floder
        echo "开始导入..."
        import ${floder}
fi
