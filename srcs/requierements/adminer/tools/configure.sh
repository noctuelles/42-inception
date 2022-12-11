#!/bin/bash

./wait

#if [ ! -d ${ADM_PATH} ]; then
#	mkdir -p ${ADM_PATH}
#	curl ${ADM_MYSQL_DOWNLOAD_LINK} -o ${ADM_PATH}/index.php
#fi

echo "Starting php-fpm..."

exec php-fpm8.2 --nodaemonize
