# Set the base image for subsequent instructions.
FROM	debian:buster

ARG	SSL_KEY_PATH
ARG	SSL_CERT_PATH

# Run apt-get update and install nginx and openssl
RUN	apt-get update && apt-get install -y \
	nginx \
	openssl \
	gettext

RUN	mkdir -p $(dirname $SSL_KEY_PATH) && mkdir -p $(dirname $SSL_CERT_PATH) && openssl req \
	-x509 \
	-nodes \
	-days 365 \
	-newkey rsa:2048 \
	-keyout $SSL_KEY_PATH -out $SSL_CERT_PATH \
	-subj "/C=FR/ST=Ile-de-France/L=Paris/O=42 Network/OU=Ecole 42/CN=plouvel.42.fr"

# Copy the configuration file into the container.
ADD	https://github.com/ufoscout/docker-compose-wait/releases/download/2.9.0/wait	/wait
COPY	conf/plouvel.42.fr.conf plouvel.42.fr.conf.template
COPY	conf/nginx.conf /etc/nginx/nginx.conf
COPY	tools/configure.sh configure.sh

RUN	chmod +x /configure.sh && chmod +x /wait

# Expose the 443 port of our server.
EXPOSE 443/tcp

ENTRYPOINT ["./configure.sh"]
