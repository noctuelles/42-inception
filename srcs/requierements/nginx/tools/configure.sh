#!/bin/bash

export DOLLAR="$"

envsubst < plouvel.42.fr.conf.template > $NGINX_CONFIG_DIR/default

echo "Starting nginx..."
exec nginx -g 'daemon off;'
