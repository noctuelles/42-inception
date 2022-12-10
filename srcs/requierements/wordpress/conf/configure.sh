#!/bin/bash

if [[ ! -d /var/www/html/wordpress ]]; then
	wp --allow-root --path='/var/www/html/wordpress/' core download
	wp --allow-r:wq
	:oot 
fi
