#!/bin/bash

if [[ ! -d /run/php ]]; then
	mkdir -p /run/php
fi

if [[ ! -d /var/www/html/wordpress ]]; then
	wp --allow-root --path='/var/www/html/wordpress/' core download

	wp --allow-root --path='/var/www/html/wordpress/' core config \
		--dbhost=database \
		--dbname=${WP_DATABASE} \
		--dbuser=${WP_DATABASE_USER} \
		--dbpass=${WP_DATABASE_USER_PASSWORD}

	wp --allow-root --path='/var/www/html/wordpress/' core install \
		--url=plouvel.42.fr \
		--title="Mon magnifique projet Inception" \
		--admin_name=${WP_ADMIN} \
		--admin_password=${WP_ADMIN_PASSWORD} \
		--admin_email=${WP_ADMIN_EMAIL}
fi

echo "Starting php-fpm..."
exec php-fpm8.1 --nodaemonize
