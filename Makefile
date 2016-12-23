.PHONY:	serve
serve:
	docker-compose up -d

.PHONY:	migrate
migrate:
	docker-compose run spring rake db:migrate

.PHONY: clear
clear:
	docker-compose stop && yes | docker-compose rm

.PHONY:	guard
guard:
	docker-compose run spring guard

.PHONY:	fonts
fonts: node_modules
	[[ ! -d ./assets/dist/fonts/ ]] && mkdir -p ./assets/dist/fonts/
	cp node_modules/font-awesome/fonts/* ./assets/dist/fonts/

.PHONY:	node_modules
node_modules:
	npm install

.PHONY:	test
test:
	docker-compose run test

.PHONY: testp
testp:
	docker-compose run test bundle exec rspec -P spec/${P}

.PHONY: console
console:
	docker-compose exec web bundle exec rails c --sandbox

.PHONY: dbsetup
dbsetup:
	docker-compose exec web bundle exec rails db:setup
