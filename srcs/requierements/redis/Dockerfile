FROM	debian:buster

RUN apt-get update && apt-get install -y \
	redis-server \
	php-redis

EXPOSE	6379

COPY	conf/redis.conf	/etc/redis/redis.conf

ENTRYPOINT ["redis-server", "/etc/redis/redis.conf"]
