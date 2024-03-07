TOP ?= $(shell git rev-parse --show-toplevel)

DOCKER         ?= docker
DOCKER_COMPOSE ?= docker-compose
PLATFORM       ?= centos7
#PLATFORM       ?= ubuntu20.04

USER_ID ?= $(shell id -u)
GROUP_ID ?= $(shell id -g)

docker-image:
	cd $(TOP)/docker; \
		$(DOCKER) build . -f Dockerfile.$(PLATFORM) -t black-parrot-sim --build-arg USER_ID=$(USER_ID) --build-arg GROUP_ID=$(GROUP_ID) \

docker-compose:
	cd $(TOP)/docker; \
	$(DOCKER_COMPOSE) build --build-arg USER_ID=$(USER_ID) --build-arg GROUP_ID=$(GROUP_ID) black-parrot-sim

docker-run:
	cd $(TOP); \
		$(DOCKER) run --volume=$(TOP):/home/build/black-parrot-sim --user $(USER_ID):$(GROUP_ID) -it black-parrot-sim 

