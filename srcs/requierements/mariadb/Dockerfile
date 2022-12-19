FROM	debian:buster

RUN	apt-get update && apt-get install -y \
	dumb-init \
	mariadb-server \
	mariadb-common \
	mariadb-client

LABEL	version="1.0"
LABEL	description="MariaDB Server for Inception"

RUN	mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

COPY conf/mariadb-server.conf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/configure.sh configure.sh

RUN chmod +x configure.sh

EXPOSE 3306

ENTRYPOINT ["./configure.sh"]
