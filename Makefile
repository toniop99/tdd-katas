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

bin/generate-kata: NAME=$(kata)
bin/generate-kata: ## Generate a new kata structure. Usage: make bin/generate-kata kata=kata-name
	@./bin/generate-kata-structure.bash $(NAME)

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

composer/run: ACTION=$(action) PROJECT=$(project) ## Run a composer script. Usage: make composer/run action=script-name project=kata-name
composer/run-test: ACTION=test ## Run the tests of the specified project. Usage: make composer/run-test project=kata-name

composer/run-mono-merge: ## Merge the mono-repo into the specified project.
	${DOCKER_SSH} composer run mono/merge


composer/run composer/run-test:
	@./bin/execute-tests.sh $(ACTION)




