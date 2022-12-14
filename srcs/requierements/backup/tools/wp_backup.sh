#!/bin/bash

DATE=$(date +"${DATE_SUFFIX_FORMAT}")

echo "WordPress folder backup done at " $(date) " !"

tar -cf /var/backup/wp_backup_${DATE}.tar.gz /var/www/html/wordpress
