# Set the base image for subsequent instructions.
FROM	debian:buster

# Run apt-get update and install nginx and openssl
RUN	apt-get update && apt-get install -y \
	nginx \
	openssl \
	gettext

# Copy the configuration file into the container.
COPY conf/default default.template
COPY tools/script.sh script.sh

# Expose the 443 port of our server.
EXPOSE 443/tcp

ENTRYPOINT ["./script.sh"]
