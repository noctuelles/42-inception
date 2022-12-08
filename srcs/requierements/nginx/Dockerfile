# Set the base image for subsequent instructions.
FROM	debian:buster

# Run apt-get update and install nginx and openssl
RUN	apt-get update
RUN	apt-get install nginx -y
RUN	apt-get install openssl -y
RUN	apt-get install gettext-base -y

# Copy the configuration file into the container.
COPY conf/default default.template
COPY tools/script.sh script.sh

# Expose the 443 port of our server.
EXPOSE 443/tcp

ENTRYPOINT ["./script.sh"]
