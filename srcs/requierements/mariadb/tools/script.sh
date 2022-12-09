#!/bin/bash

echo -n "Initializing MariaDB data directory..."

if [[ ! -d /run/mysqld ]]; then
	mkdir -p /run/mysqld/
	chown -R mysql:mysql /run/mysqld/
fi

if [ ! -d "/var/lib/mysql/mysql" ]; then
	
	chown -R mysql:mysql /var/lib/mysql

	if mysql_install_db --user=mysql \
		--datadir=/var/lib/mysql \
		> /dev/null; then
		echo " Sucess!"
	else
		echo " Failure!"
		exit 1
	fi

	echo "Executing init SQL script..."

	tmpfile=$(mktemp)

	cat << EOF > $tmpfile
UPDATE mysql.user SET Password = PASSWORD('${MYSQL_ROOT_PASSWORD}') WHERE User = 'root';
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
FLUSH PRIVILEGES;

CREATE DATABASE ${WP_DATABASE} CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER '${WP_DATABASE_USER}'@'localhost' IDENTIFIED BY '${WP_DATABASE_USER_PASSWORD}';
GRANT ALL PRIVILEGES ON ${WP_DATABASE}.* TO '${WP_DATABASE_USER}'@'localhost' IDENTIFIED BY '${WP_DATABASE_USER_PASSWORD}';
FLUSH PRIVILEGES;
EOF
	# https://mariadb.com/kb/en/mysqld-options/#-bootstrap

	if ! mysqld --user=mysql --verbose --bootstrap < $tmpfile ; then
		exit 1
	fi

	rm -rf $tmpfile
else
	echo " already configured."
fi

echo "All good now! Starting deamon."

exec mysqld --user=mysql
