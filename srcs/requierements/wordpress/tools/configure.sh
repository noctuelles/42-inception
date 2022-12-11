#!/bin/bash

if ! wp --allow-root --path='/var/www/html' config get > /dev/null; then
	if ! wp --allow-root --path='/var/www/html' core download; then
		echo " Failure."
		exit 1
	fi

	if ! wp --allow-root --path='/var/www/html' core config \
		--dbhost=database \
		--dbname=${WP_DB_NAME} \
		--dbuser=${WP_DB_USER} \
		--dbpass=${WP_DB_USER_PWD}; then
		echo " Failure."
		exit 1
	fi

	wp --allow-root --path='/var/www/html' config set WP_REDIS_HOST cache
	wp --allow-root --path='/var/www/html' config set WP_REDIS_PORT 6379 
	wp --allow-root --path='/var/www/html' config set WP_REDIS_SCHEME tcp 
	wp --allow-root --path='/var/www/html' config set WP_REDIS_DATABASE 0 
	wp --allow-root --path='/var/www/html' config set WP_CACHE_KEY_SALT plouvel.42.fr 
	wp --allow-root --path='/var/www/html' config set WP_CACHE true 

	if ! wp --allow-root --path='/var/www/html' core install \
		--url=plouvel.42.fr \
		--title="${WP_BLOG_TITLE}" \
		--admin_name=${WP_ADMIN_NAME} \
		--admin_password=${WP_ADMIN_PWD} \
		--admin_email=${WP_ADMIN_EMAIL}; then
		echo " Failure."
		exit 1
	fi

	chown -R www-data:www-data /var/www/html

	wp --allow-root --path='/var/www/html' plugin install redis-cache --activate 
fi

echo "Starting php-fpm..."

exec php-fpm8.1 --nodaemonize
