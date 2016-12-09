.PHONY:	serve
serve:
	docker-compose up -d

.PHONY:	migrate
migrate:
	docker-compose run spring rake db:migrate

.PHONY:	watch
watch:
	docker-compose run spring guard watch

.PHONY:	test
test:
	docker-compose run test
