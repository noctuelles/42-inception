# Set the base image for subsequent instructions.
FROM	debian:buster

# Run apt-get update and install nginx and openssl
RUN	apt-get update && apt-get install -y \
	cron \
	dumb-init \
	mariadb-client

COPY	tools/configure.sh 	/configure.sh
COPY	tools/wp_backup.sh	/scripts/wp_backup.sh
COPY	tools/mysql_backup.sh	/scripts/mysql_backup.sh

ADD	https://github.com/ufoscout/docker-compose-wait/releases/download/2.9.0/wait	/wait
RUN	chmod +x /configure.sh && chmod +x /scripts/wp_backup.sh \
	&& chmod +x /wait && chmod +x /scripts/mysql_backup.sh

ENTRYPOINT ["./configure.sh"]
