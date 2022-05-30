#!/bin/bash

#使用挂载的配置文件
cp /slave-config/standby.signal /var/lib/postgresql/data/
rm  /var/lib/postgresql/data/postgresql.conf
cp /slave-config/postgresql.conf  /var/lib/postgresql/data/

#重启数据库，更新配置
su postgres
pg_ctl restart

#与主库进行同步
rm -rf  /var/lib/postgresql/data/*
pg_basebackup -h 192.168.0.103 -p 5440 -U replica -F p  -P -R -D /var/lib/postgresql/data/ -l postgresbackup2022

