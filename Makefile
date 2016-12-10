.PHONY:	serve
serve:
	docker-compose up -d

.PHONY:	migrate
migrate:
	docker-compose run spring rake db:migrate

.PHONY:	test
test:
	docker-compose run test

.PHONY: testp
testp:
	docker-compose run test bundle exec rspec -P spec/${P}
