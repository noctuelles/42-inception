DOCKER_COMPOSE_YML	=	srcs/docker-compose.yml

RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
$(eval $(RUN_ARGS):;@:)

all:	build up

build:
	docker compose -f ${DOCKER_COMPOSE_YML} build ${RUN_ARGS}

build_nocache:
	docker compose -f ${DOCKER_COMPOSE_YML} build --no-cache ${RUN_ARGS}

up:
	docker compose -f ${DOCKER_COMPOSE_YML} up ${RUN_ARGS}

stop:
	docker compose -f ${DOCKER_COMPOSE_YML} stop ${RUN_ARGS}

down:
	docker compose -f ${DOCKER_COMPOSE_YML} down ${RUN_ARGS}

exec:
	docker compose -f ${DOCKER_COMPOSE_YML} exec ${RUN_ARGS}

logs:
	docker compose -f ${DOCKER_COMPOSE_YML} logs ${RUN_ARGS}

wipe_volume_data:
	sudo rm -rf /home/plouvel/data/wp/* /home/plouvel/data/mysql/* /home/plouvel/data/adminer/* /home/plouvel/data/backup/*

wipe_backup:
	rm -rf /home/plouvel/data/backup/*

create_volume_dir:
	mkdir -p /home/plouvel/data/wp && mkdir -p /home/plouvel/data/mysql && mkdir -p /home/plouvel/data/adminer && mkdir -p /home/plouvel/data/backup && /home/plouvel/data/perso

fclean:	stop down wipe_volume_data build_nocache

re: fclean up

.PHONY: all build build_nocache up stop down exec logs wipe_volume_data fclean re
