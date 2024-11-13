TOP ?= $(shell git rev-parse --show-toplevel)

DOCKER         ?= docker
DOCKER_COMPOSE ?= docker-compose
PLATFORM       ?= ubuntu20.04

docker-image:
	cd $(TOP)/docker; \
		$(DOCKER) build . -f Dockerfile.$(PLATFORM) -t black-parrot-sim --no-cache --build-arg USER_ID=$(shell id -u) --build-arg GROUP_ID=$(shell id -g) \

docker-compose:
	cd $(TOP)/docker; \
	$(DOCKER_COMPOSE) build --build-arg USER_ID=$(shell id -u) --build-arg GROUP_ID=$(shell id -g) black-parrot-sim
	$(DOCKER_COMPOSE) up -d
	$(DOCKER_COMPOSE) exec bp su - build

docker-run:
	cd $(TOP); \
		$(DOCKER) run --volume=$(TOP):/home/build/black-parrot-sim --user $(shell id -u):$(shell id -g) -it black-parrot-sim 

