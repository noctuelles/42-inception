#!/bin/bash

./wait

export DOLLAR="$"

envsubst < plouvel.42.fr.conf.template > $NGINX_CONFIG_DIR/plouvel.42.fr.conf
envsubst < adminer.42.fr.conf.template > $NGINX_CONFIG_DIR/adminer.42.fr.conf
envsubst < perso.42.fr.conf.template > $NGINX_CONFIG_DIR/perso.42.fr.conf

echo "Starting nginx..."
exec nginx -g 'daemon off;'
