FROM	debian:buster

RUN apt-get update && apt-get install -y \
	gnupg2 \
	ca-certificates \
	apt-transport-https \
	software-properties-common \
	wget \
	curl \
	&& echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list \
	&& wget -qO - https://packages.sury.org/php/apt.gpg | apt-key add - \
	&& apt-get update && apt-get install -y \
	php-mysql \
	php-common \
	php-fpm \
	mariadb-client

ADD	https://github.com/ufoscout/docker-compose-wait/releases/download/2.9.0/wait	/wait
COPY	tools/configure.sh 	/configure.sh

RUN	chmod +x /configure.sh && chmod +x /wait

EXPOSE 9000/tcp

ENTRYPOINT ["/configure.sh"]
