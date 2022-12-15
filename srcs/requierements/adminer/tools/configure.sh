#!/bin/bash

set -e

./wait

if [ ! -f ${ADM_PATH}/index.php ]; then
	echo "Downloading adminer..."
	wget -q -O ${ADM_PATH}/index.php ${ADM_MYSQL_DOWNLOAD_LINK}
	echo "Done."
fi

echo "Starting php-fpm..."

exec php-fpm8.2 --nodaemonize
