DOCKER_COMPOSE_YML	=	./srcs/docker-compose.yml

RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
$(eval $(RUN_ARGS):;@:)

all:	build up

build:
	docker compose -f ${DOCKER_COMPOSE_YML} build ${RUN_ARGS}

up:
	docker compose -f ${DOCKER_COMPOSE_YML} up -d ${RUN_ARGS}

stop:
	docker compose -f ${DOCKER_COMPOSE_YML} stop ${RUN_ARGS}

down:
	docker compose -f ${DOCKER_COMPOSE_YML} down ${RUN_ARGS}

exec:
	docker compose -f ${DOCKER_COMPOSE_YML} exec ${RUN_ARGS}

logs:
	docker compose -f ${DOCKER_COMPOSE_YML} logs ${RUN_ARGS}

wipe_volume_data: stop down
	sudo rm -rf /home/plouvel/data/wp/* \
		/home/plouvel/data/wp/.init* \
		/home/plouvel/data/mysql/* \
		/home/plouvel/data/mysql/.init* \
		/home/plouvel/data/adminer/* \
		/home/plouvel/data/backup/* \
		/home/plouvel/data/backup/.init*

wipe_backup:
	rm -rf /home/plouvel/data/backup/*

create_volume_dir:
	mkdir -p /home/plouvel/data/wp && mkdir -p /home/plouvel/data/mysql && mkdir -p /home/plouvel/data/adminer && mkdir -p /home/plouvel/data/backup && /home/plouvel/data/perso

fclean:	stop down wipe_volume_data

re: fclean up

.PHONY: all build up stop down exec logs wipe_volume_data wipe_backup fclean re
