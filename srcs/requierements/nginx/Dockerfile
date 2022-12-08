# Set the base image for subsequent instructions.
FROM	debian:buster

ARG key_dir
ARG cert_dir
ARG key_name 
ARG cert_name 

# Run apt-get update and install nginx and openssl
RUN	apt-get update \
	&& apt-get install nginx -y \
	&& apt-get install openssl -y

RUN	mkdir -p $private_key_dir && mkdir -p $cert_dir \
	&& openssl req \
	-x509 \
	-nodes \
	-days 365 \
	-newkey rsa:2048 \
	-keyout $private_key_dir/$key_name -out $cert_dir/$cert_name \
	-subj "/C=FR/ST=Ile-de-France/L=Paris/O=42 Network/OU=Ecole 42/CN=plouvel.42.fr"

# Copy the configuration file into the container.
COPY default /etc/nginx/sites-available/default

# Expose the 443 port of our server.
EXPOSE 443/tcp

CMD ["nginx", "-g", "daemon off;"]
