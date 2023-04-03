SHELL := /bin/bash

DOCKER_PHP = php_tdd_katas
UID = 1000:1000

DOCKER_EXEC = docker exec -i -u ${UID} -e "TERM=xterm-256color"
DOCKER_EXEC_INTERACTIVE = docker exec -it -u ${UID} -e "TERM=xterm-256color"
DOCKER_SSH = ${DOCKER_EXEC} ${DOCKER_PHP}

.PHONY: help
help: ## Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

ssh: ## SSH into the PHP container.
	@${DOCKER_EXEC_INTERACTIVE} ${DOCKER_PHP} bash

.PHONY: generate-kata
generate-kata: NAME=$(kata)
generate-kata: ## Generate a new kata structure. Usage: make generate-kata kata=kata-name
	@./bin/shell/generate-kata-skeleton.bash $(NAME)

docker/up: ## Start the docker containers.
	docker-compose up -d --remove-orphans

docker/down: ## Stop the docker containers.
	docker-compose down --remove-orphans

docker/build: ## Build the docker containers.
	docker-compose build --no-cache

composer/install: ## Install the composer dependencies.
	${DOCKER_SSH} composer install --no-interaction --optimize-autoloader

composer/update: ## Update the composer dependencies.
	${DOCKER_SSH} composer update --no-interaction --optimize-autoloader

composer/run-mono-merge: ## Merge the mono-repo into the specified project.
	${DOCKER_SSH} composer run mono/merge

command: ## Run a command in the PHP container. Usage: make command generate:kata-skeleton
	@${DOCKER_SSH} ./bin/console $(filter-out command,$(MAKECMDGOALS))

command/test:
	@${DOCKER_SSH} ./bin/console test

command/generate-skeleton:
	@${DOCKER_SSH} ./bin/console generate:kata-skeleton




