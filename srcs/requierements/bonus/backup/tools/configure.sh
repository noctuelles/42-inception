#!/usr/bin/dumb-init /bin/bash

./wait

useradd -u ${LOCAL_USER_UID} -o -M ${LOCAL_USER_NAME}
groupmod -g ${LOCAL_USER_GID} ${LOCAL_USER_NAME}

chown -R ${LOCAL_USER_NAME}:${LOCAL_USER_NAME} /var/backup

set -e

env >> /etc/environment

cat << EOF > /etc/crontab
SHELL=/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
BASH_ENV=/etc/environment

${WP_BACKUP_OCCURENCE} ${LOCAL_USER_NAME} /scripts/wp_backup.sh
${MYSQL_BACKUP_OCCURENCE} ${LOCAL_USER_NAME} /scripts/mysql_backup.sh
EOF

echo "Starting cron..."

exec cron -f -L 1
