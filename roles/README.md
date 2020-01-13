在控制节点安装ansible：yum install ansible -y   使用7的源，版本为2.8.4

1.修改hosts文件，将IP改为实际部署业务系统的IP.每个组代表部署业务系统的IP.
2.修改playbooks/web_update.yml，hosts与hosts文件中保持一致，remote_user修改为实际业务系统启动用户，role与roles下目录名保持一致.
3.将更新的部署包放到/etc/ansible/roles/web_update/files目录下，文件名类似portal-web.tar.gz.同一台机器上的系统更新包，下载到同一目录下.
4.配置文件模板放在/etc/ansible/roles/web_update/templates目录下，一般不需要修改，如果发现个别前端域名不生效，再查看模板.
5.变量放在/etc/ansible/roles/web_update/vars目录下，已经写好注释，可酌情处理.
6.主要更新过程的playbook放在/etc/ansible/roles/web_update/tasks目录下，同一个机器上的业务系统升级过程添加到同一个main.yml文件中。其中需要注意修改系统升级包前缀与部署路径以及启动用户.
7.执行升级命令：cd /etc/ansible && ansible-playbook playbooks/web_update.yml
