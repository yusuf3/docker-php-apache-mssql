compose-file = docker-compose.yml

docker-start:
	docker-compose -f $(compose-file) start
docker-build:
	docker-compose -f $(compose-file) up --build --remove-orphans --force-recreate -d
docker-build-watch:
	docker-compose -f $(compose-file) up --build --remove-orphans --force-recreate
docker-stop:
	docker-compose -f $(compose-file) stop
docker-run-bash:
	docker-compose -f $(compose-file) exec app bash
docker-up:
	docker-compose -f $(compose-file) up -d
docker-down:
	docker-compose -f $(compose-file) down
dump-autoload:
	docker-compose -f $(compose-file) exec app composer dump-autoload
optimize:
	docker-compose -f $(compose-file) exec app php artisan optimize:clear
docker-migrate:
	docker-compose -f $(compose-file) exec app php artisan migrate
composer-install:
	docker-compose -f $(compose-file) exec app composer install
logs:
	docker-compose -f $(compose-file) logs app
a2enmod:
	docker-compose -f $(compose-file) exec app a2enmod rewrite
a2ensite:
	docker-compose -f $(compose-file) exec app a2ensite moodle.conf
a2dissite:
	docker-compose -f $(compose-file) exec app a2dissite 000-default.conf
apache-reload:
	docker-compose -f $(compose-file) exec app service apache2 reload
deploy:
	make docker-build
	make a2enmod
	make a2ensite
	make a2dissite
	make apache-reload
