
#使用挂载的配置文件
rm /var/lib/postgresql/data/pg_hba.conf
rm /var/lib/postgresql/data/postgresql.conf
cp /master-config/pg_hba.conf /var/lib/postgresql/data/
cp /master-config/postgresql.conf /var/lib/postgresql/data/

#数据库中create新角色
psql -v ON_ERROR_STOP=1 --username postgres <<-EOSQL
	set synchronous_commit =off;
	create role replica login replication encrypted password '123456';
EOSQL

#重启数据库，更新配置
su postgres
pg_ctl restart