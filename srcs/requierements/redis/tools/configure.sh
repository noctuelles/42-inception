#!/bin/bash

set -e

./wait

echo "Starting redis-server..."

exec redis-server /etc/redis/redis.conf
