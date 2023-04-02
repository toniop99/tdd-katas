SHELL := /bin/bash

DOCKER_PHP = php_tdd_katas
UID = 1000:1000

DOCKER_EXEC = docker exec -i -u ${UID}
DOCKER_EXEC_INTERACTIVE = docker exec -it -u ${UID}
DOCKER_SSH = ${DOCKER_EXEC} ${DOCKER_PHP}

ssh:
	${DOCKER_EXEC_INTERACTIVE} ${DOCKER_PHP} bash

docker/up:
	docker-compose up -d --remove-orphans

docker/down:
	docker-compose down --remove-orphans

docker/build:
	docker-compose build --no-cache

composer/install:
	${DOCKER_SSH} composer install --no-interaction --optimize-autoloader

composer/update:
	${DOCKER_SSH} composer update --no-interaction --optimize-autoloader

composer/run: ACTION=$(action) PROJECT=$(project)
composer/run-test: ACTION=test

composer/run composer/run-test:
	@./bin/execute-tests.sh $(ACTION)




