FROM	debian:buster

# Run `docker build --no-cache .` to update dependencies
RUN apt-get update && apt-get install -y \
	gnupg2 ca-certificates apt-transport-https software-properties-common wget curl \
	&& echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list \
	&& wget -qO - https://packages.sury.org/php/apt.gpg | apt-key add - \
	&& apt-get update && apt-get install -y \
	php-cgi php-common php-mbstring php-zip php-net-socket php-gd php-xml-util php-gettext php-mysql php-bcmath php-fpm \
	&& rm -rf /var/lib/apt/lists/*

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp

# COPY conf/php.ini /etc/php/7.3/fpm/
COPY conf/configure.sh configure.sh
RUN chmod +x configure.sh
