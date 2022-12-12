#!/bin/bash

DATE=$(date +"${DATE_SUFFIX_FORMAT}")

tar -cf /var/backup/wp_backup_${DATE}.tar.gz /var/www/html/wordpress
