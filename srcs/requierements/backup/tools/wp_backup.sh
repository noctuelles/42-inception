#!/bin/bash

DATE=$(date +"%Y_%b_%d_%I_%M_%S")

tar -cf /var/backup/wp_backup_${DATE}.tar.gz /var/www/html/wordpress
