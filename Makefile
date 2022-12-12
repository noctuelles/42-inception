DOCKER_COMPOSE_YML	=	srcs/docker-compose.yml

all:	build up

build:
	docker compose -f ${DOCKER_COMPOSE_YML} build

build_nocache:
	docker compose -f ${DOCKER_COMPOSE_YML} build --no-cache

up:
	docker compose -f ${DOCKER_COMPOSE_YML} up -d

stop:
	docker compose -f ${DOCKER_COMPOSE_YML} stop

down:
	docker compose -f ${DOCKER_COMPOSE_YML} down

wipe_volume_data:
	sudo rm -rf /home/plouvel/data/wp/* /home/plouvel/data/mysql/* /home/plouvel/data/adminer/*

clean:	stop down build_nocache

re: clean up

.PHONY: all build build_nocache up stop down wipe_volume_data clean
