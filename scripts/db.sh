yum install https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm -y
yum install postgresql12-server -y
echo "listen_addresses='*'" >> /etc/postgresql/12/main/postgresql.conf
echo "host all all 192.168.33.1/24 md5" >> /etc/postgresql/12/main/pg_hba.conf
service postgresql restart


echo ++++ **Script install and start PostgreSQL** ++++




