#!/bin/bash

export DOLLAR="$"

echo -n "Creating self-signed certificate..."

mkdir -p $(dirname $SSL_KEY_PATH)
mkdir -p $(dirname $SSL_CERT_PATH)

if openssl req \
	-x509 \
	-nodes \
	-days 365 \
	-newkey rsa:2048 \
	-keyout $SSL_KEY_PATH -out $SSL_CERT_PATH \
	-subj "/C=FR/ST=Ile-de-France/L=Paris/O=42 Network/OU=Ecole 42/CN=plouvel.42.fr" \
	2>/dev/null; then
	echo " Sucess!"
else
	echo " Failure!"
	exit 1
fi

envsubst < default.template > $NGINX_CONFIG_DIR/default

echo "Starting nginx..."
exec nginx -g 'daemon off;'
