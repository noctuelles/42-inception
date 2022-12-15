FROM	debian:buster

RUN apt-get update && apt-get install -y \
	redis-server \
	php-redis

EXPOSE	6379

ADD	https://github.com/ufoscout/docker-compose-wait/releases/download/2.9.0/wait	/wait
COPY	conf/redis.conf	/etc/redis/redis.conf
COPY	tools/configure.sh configure.sh

RUN	chmod +x /configure.sh && chmod +x /wait

ENTRYPOINT ["./configure.sh"]
