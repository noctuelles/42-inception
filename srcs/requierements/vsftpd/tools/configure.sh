#!/usr/bin/dumb-init /bin/bash

set -e

echo "local_root=/var/www/html/wordpress" > /etc/vsftpd/${FTP_USER_NAME}

envsubst < vsftpd.conf.template > /etc/vsftpd.conf

exec vsftpd
