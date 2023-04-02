SHELL := /bin/bash

DOCKER_PHP = php_tdd_katas
UID = 1000:1000

DOCKER_EXEC = docker exec -i -u ${UID}
DOCKER_EXEC_INTERACTIVE = docker exec -it -u ${UID}
DOCKER_SSH = ${DOCKER_EXEC} ${DOCKER_PHP}

.PHONY: help
help: ## Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

ssh: ## SSH into the PHP container.
	${DOCKER_EXEC_INTERACTIVE} ${DOCKER_PHP} bash

.PHONY: generate-kata
generate-kata: NAME=$(kata)
generate-kata: ## Generate a new kata structure. Usage: make generate-kata kata=kata-name
	@./console/generate-kata-structure.bash $(NAME)

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

command/test:
	@${DOCKER_SSH} ./console/application.php test



