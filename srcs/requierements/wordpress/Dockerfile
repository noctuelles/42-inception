FROM	debian:buster

# Run `docker build --no-cache .` to update dependencies
RUN apt-get update && apt-get install -y \
	gnupg2 \
	ca-certificates \
	apt-transport-https \
	software-properties-common \
	wget \
	curl \
	&& echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list \
	&& wget -qO - https://packages.sury.org/php/apt.gpg | apt-key add - 

RUN apt-get update && apt-get install -y \
	php-cgi \
	php-common \
	php-mbstring \
	php-zip \
	php-net-socket \
	php-gd php-xml-util \
	php-gettext \
	php-mysql \
	php-bcmath \
	php-fpm \
	mariadb-client \
	sendmail \
	&& rm -rf /var/lib/apt/lists/*

# Installing WP-CLI (Wordpress Command Line Interpreter)
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp

COPY tools/configure.sh configure.sh
COPY conf/php.ini	/etc/php/8.1/fpm/php.ini
COPY conf/www.conf	/etc/php/8.1/fpm/pool.d/www.conf

RUN chmod +x configure.sh

EXPOSE 9000/tcp

ENTRYPOINT ["./configure.sh"]
