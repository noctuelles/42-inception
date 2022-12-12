#!/bin/bash

./wait

chown -R www-data:www-data ${WP_PATH}

if ! wp --allow-root --path="${WP_PATH}" config get > /dev/null; then
	wp --allow-root --path="${WP_PATH}" core download

	wp --allow-root --path="${WP_PATH}" core config \
		--dbhost=database \
		--dbname=${WP_DB_NAME} \
		--dbuser=${WP_DB_USER} \
		--dbpass=${WP_DB_USER_PWD};

	wp --allow-root --path="${WP_PATH}" config set WP_REDIS_HOST cache
	wp --allow-root --path="${WP_PATH}" config set WP_REDIS_PORT 6379 
	wp --allow-root --path="${WP_PATH}" config set WP_REDIS_SCHEME tcp 
	wp --allow-root --path="${WP_PATH}" config set WP_REDIS_DATABASE 0 
	wp --allow-root --path="${WP_PATH}" config set WP_CACHE_KEY_SALT plouvel.42.fr 
	wp --allow-root --path="${WP_PATH}" config set WP_CACHE true 

	wp --allow-root --path="${WP_PATH}" core install \
		--url=plouvel.42.fr \
		--title="${WP_BLOG_TITLE}" \
		--admin_name=${WP_ADMIN_NAME} \
		--admin_password=${WP_ADMIN_PWD} \
		--admin_email=${WP_ADMIN_EMAIL}

	wp --allow-root --path="${WP_PATH}" plugin install redis-cache --activate 
	wp --allow-root --path="${WP_PATH}" plugin update --all
    	wp --allow-root --path="${WP_PATH}" redis enable
fi

echo "Starting php-fpm..."

exec php-fpm8.2 --nodaemonize
