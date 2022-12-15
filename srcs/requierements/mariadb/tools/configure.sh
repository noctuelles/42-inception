#!/bin/bash

set -e

chown -R mysql:mysql /var/lib/mysql

if [ ! -f "/var/lib/mysql/.init-sql" ]; then
	echo "Configuring MariaDB..."

	mysql_install_db --user=mysql \
		--datadir=/var/lib/mysql \
		> /dev/null

	tmpfile=$(mktemp)

	cat << EOF > $tmpfile
UPDATE mysql.user SET Password = PASSWORD('${MYSQL_ROOT_PWD}') WHERE User = 'root';
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
FLUSH PRIVILEGES;

CREATE DATABASE ${WP_DB_NAME} CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER '${WP_DB_USER}'@'%' IDENTIFIED BY '${WP_DB_USER_PWD}';
GRANT ALL PRIVILEGES ON ${WP_DB_NAME}.* TO '${WP_DB_USER}'@'%' IDENTIFIED BY '${WP_DB_USER_PWD}';
FLUSH PRIVILEGES;
EOF
	# https://mariadb.com/kb/en/mysqld-options/#-bootstrap

	mysqld --user=mysql --bootstrap < $tmpfile

	rm -rf $tmpfile

	touch /var/lib/mysql/.init-sql
fi

echo "Starting mysqld..."

exec mysqld --user=mysql
