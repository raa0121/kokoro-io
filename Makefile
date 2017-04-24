.PHONY:	build
build:
	docker-compose build

.PHONY:	serve
serve:
	docker-compose up -d

.PHONY:	restart
restart:
	docker-compose stop && yes | docker-compose rm | docker-compose up -d

.PHONY:	migrate
migrate:
	docker-compose run spring rake db:migrate

.PHONY: clear
clear:
	docker-compose stop && yes | docker-compose rm

.PHONY:	guard
guard:
	docker-compose run spring guard

.PHONY:	test
test:
	docker-compose run test

.PHONY: testm
testm:
	docker-compose run test bundle exec rake spec:models

.PHONY: testv
testv:
	docker-compose run test bundle exec rake spec:views

.PHONY: testc
testc:
	docker-compose run test bundle exec rake spec:controllers

.PHONY: testr
testr:
	docker-compose run test bundle exec rake spec:requests

.PHONY: testh
testh:
	docker-compose run test bundle exec rake spec:helpers


.PHONY: testp
testp:
	docker-compose run test bundle exec rspec -P spec/${P}

.PHONY: console
console:
	docker-compose exec web bundle exec rails c --sandbox

.PHONY: dbdrop
dbdrop:
	docker-compose exec web bundle exec rails db:drop

.PHONY: dbreset
dbreset:
	docker-compose exec web bundle exec rails db:reset

.PHONY: dbsetup
dbsetup:
	docker-compose exec web bundle exec rails db:setup

.PHONY: dbseed
dbseed:
	docker-compose exec web bundle exec rails db:seed

.PHONY: tslint
tslint:
	docker-compose exec assets npm run tslint

.PHONY: bi
bi:
	docker-compose exec web bundle install
