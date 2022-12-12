#!/bin/bash

DATE=$(date +"${DATE_SUFFIX_FORMAT}")

mysqldump \
	--host=database \
	--all-databases \
	--user=${WP_DB_USER} \
	--password=${WP_DB_USER_PWD} \
	--result-file=/var/backup/mysql_dump_${DATE}.sql
