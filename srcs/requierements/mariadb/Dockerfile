FROM	debian:buster

RUN	apt-get update && apt-get install -y \
	mariadb-server \
	mariadb-common \
	mariadb-client

LABEL	version="1.0"
LABEL	description="MariaDB Server for Inception"

COPY tools/script.sh script.sh

EXPOSE 3306

ENTRYPOINT ["./script.sh"]
