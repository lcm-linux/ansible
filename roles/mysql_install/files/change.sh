#!/usr/bin/env bash
mysql  -uroot << EOF
set password = password("k007k007");
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'k007k007';
GRANT ALL PRIVILEGES ON *.* TO 'root'@localhost IDENTIFIED BY 'k007k007';
CREATE USER 'servent'@'%' IDENTIFIED BY 'k007k007';
GRANT ALL PRIVILEGES ON *.* TO 'servent'@'%' IDENTIFIED BY 'k007k007' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'servent'@'localhost' IDENTIFIED BY 'k007k007' WITH GRANT OPTION;
GRANT REPLICATION SLAVE,REPLICATION CLIENT ON *.* to 'servent'@'%' identified by 'k007k007';
GRANT REPLICATION SLAVE,REPLICATION CLIENT ON *.* to 'servent'@'localhost' identified by 'k007k007';
flush privileges;
EOF
