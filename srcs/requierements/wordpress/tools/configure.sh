#!/bin/bash

set -e

./wait

chown -R www-data:www-data /var/www

if [ ! -f "${WP_PATH}/.init-wp" ]; then
	su-exec www-data wp --path="${WP_PATH}" core download

	su-exec www-data wp --path="${WP_PATH}" core config \
		--dbhost=database \
		--dbname=${WP_DB_NAME} \
		--dbuser=${WP_DB_USER} \
		--dbpass=${WP_DB_USER_PWD};

	su-exec www-data wp --path="${WP_PATH}" config set WP_REDIS_HOST cache
	su-exec www-data wp --path="${WP_PATH}" config set WP_REDIS_PORT 6379 
	su-exec www-data wp --path="${WP_PATH}" config set WP_REDIS_SCHEME tcp 
	su-exec www-data wp --path="${WP_PATH}" config set WP_REDIS_DATABASE 0 
	su-exec www-data wp --path="${WP_PATH}" config set WP_CACHE_KEY_SALT plouvel.42.fr 
	su-exec www-data wp --path="${WP_PATH}" config set WP_CACHE true 

	su-exec www-data wp --path="${WP_PATH}" core install \
		--url=plouvel.42.fr \
		--title="${WP_BLOG_TITLE}" \
		--admin_name=${WP_ADMIN_NAME} \
		--admin_password=${WP_ADMIN_PWD} \
		--admin_email=${WP_ADMIN_EMAIL}

	su-exec www-data wp --path="${WP_PATH}" plugin install redis-cache --activate 
	su-exec www-data wp --path="${WP_PATH}" plugin update --all
    	su-exec www-data wp --path="${WP_PATH}" redis enable

	touch "${WP_PATH}/.init-wp"
fi

echo "Starting php-fpm..."

exec php-fpm8.2 --nodaemonize
