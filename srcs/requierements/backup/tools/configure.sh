#!/bin/bash

./wait

env >> /etc/environment

cat << EOF > /etc/crontab
SHELL=/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
BASH_ENV=/etc/environment

${WP_BACKUP_OCCURENCE} root /scripts/wp_backup.sh
${MYSQL_BACKUP_OCCURENCE} root /scripts/mysql_backup.sh
EOF

echo "Starting cron..."

exec cron -f
