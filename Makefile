.PHONY:	serve
serve:
	docker-compose up -d

.PHONY:	migrate
migrate:
	docker-compose run spring rake db:migrate

.PHONY:	guard
guard:
	docker exec $$(docker-compose ps -q spring) ln -f -s ${PWD}/node_modules/webpack/bin/webpack.js /usr/local/bin/webpack.js
	docker-compose run spring guard

.PHONY:	test
test:
	docker-compose run test

.PHONY: testp
testp:
	docker-compose run test bundle exec rspec -P spec/${P}
