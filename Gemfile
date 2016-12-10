source 'https://rubygems.org'

gem 'therubyracer'
gem 'libv8', '3.16.14.15'
gem 'rails', '~> 5.0.0.1'
gem 'sass-rails', '~> 5.0.4'
gem 'slim-rails', '~> 3.1'
gem 'uglifier', '>= 2.7.2'
gem 'coffee-rails', '~> 4.1.0'
gem 'omniauth', '~> 1.2'
gem 'omniauth-github', '~> 1.1'

gem 'jquery-rails'
gem 'turbolinks'
gem 'jquery-turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'rake', '10.4.2'
gem 'sdoc', '~> 0.4.1',          group: :doc

gem 'activeadmin', github: 'gregbell/active_admin'
gem 'inherited_resources', github: 'activeadmin/inherited_resources'
gem 'devise'

gem 'simple_form', github: 'plataformatec/simple_form'
gem 'friendly_id', github: 'norman/friendly_id'

# gem 'cancancan', '~> 1.13.1'
gem 'pundit'

gem 'unicorn'
gem 'foreman'

## API

## Faye
# gem 'faye-websocket'
gem 'pusher'
gem 'vuejs-rails'

group :development do
  gem 'guard'
  gem 'guard-sass'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'spring'
  # Deploy
  gem 'mina'
  gem 'mina-unicorn', require: false
end

group :provisioning do
  gem 'itamae'
  gem 'serverspec'
end

group :test do
  gem 'rails-controller-testing'
  gem 'rspec-rails'
  gem 'database_cleaner'
  gem 'capybara'
  gem 'factory_girl_rails'
end

group :production, :staging, :test do
  gem 'pg'
end

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'


# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development



# Use debugger
# gem 'debugger', group: [:development, :test]

