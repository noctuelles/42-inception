#!/bin/bash

./wait

if [ ! -f ${ADM_PATH}/index.php ]; then
	wget -q -O ${ADM_PATH}/index.php ${ADM_MYSQL_DOWNLOAD_LINK}
fi

echo "Starting php-fpm..."

exec php-fpm8.2 --nodaemonize
