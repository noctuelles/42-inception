# Set the base image for subsequent instructions.
FROM	debian:buster

# Run apt-get update and install nginx and openssl
RUN	apt-get update && apt-get install -y \
	cron \
	gettext \
	mariadb-client

COPY	tools/configure.sh 	/configure.sh
COPY	tools/wp_backup.sh	/scripts/wp_backup.sh
COPY	conf/crontab		/etc/crontab

RUN	chmod +x /configure.sh && chmod +x /scripts/wp_backup.sh

ENTRYPOINT ["./configure.sh"]
