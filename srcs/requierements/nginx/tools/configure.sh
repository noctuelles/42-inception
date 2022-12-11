#!/bin/bash

./wait

export DOLLAR="$"

envsubst < plouvel.42.fr.conf.template > $NGINX_CONFIG_DIR/plouvel.42.fr.conf
envsubst < adminer.conf.template > $NGINX_CONFIG_DIR/adminer.conf

echo "Starting nginx..."
exec nginx -g 'daemon off;'
