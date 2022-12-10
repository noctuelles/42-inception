# Set the base image for subsequent instructions.
FROM	debian:buster

# Run apt-get update and install nginx and openssl
RUN	apt-get update && apt-get install -y \
	nginx \
	openssl \
	gettext

# Copy the configuration file into the container.
COPY conf/plouvel.42.fr.conf plouvel.42.fr.conf.template
COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY tools/configure.sh configure.sh

# Expose the 443 port of our server.
EXPOSE 443/tcp

ENTRYPOINT ["./configure.sh"]
