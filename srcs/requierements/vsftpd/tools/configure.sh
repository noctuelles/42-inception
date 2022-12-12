#!/bin/bash

set -e

echo "local_root=/var/www/html/wordpress" > /etc/vsftpd/${FTP_USER_NAME}

envsubst < vsftpd.conf.template > /etc/vsftpd.conf

# Est-ce que c'est un hacky patch ?

vsftpd_stop() {
	  # Get PID
	  pid="$(cat /var/run/vsftpd/vsftpd.pid)"
	  # Set TERM
	  kill -SIGTERM "${pid}"
	  # Wait for exit
	  wait "${pid}"
	  # All done.
}

if [[ "${1}" == "vsftpd" ]]; then
	  trap vsftpd_stop SIGINT SIGTERM
	  echo "Starting ${*}..."
	  # Launch vsftpd in the background
	  "${@}" &
	  pid="${!}"
	  echo "${pid}" > /var/run/vsftpd/vsftpd.pid
	  wait "${pid}" && exit ${?}
else
	  exec "${@}"
fi
