source 'https://rubygems.org'


gem 'rails', '4.2.4'
gem 'sass-rails', '~> 5.0.4'
gem 'slim-rails', '~> 3.0.1'
gem 'uglifier', '>= 2.7.2'
gem 'coffee-rails', '~> 4.1.0'
gem 'omniauth', '~> 1.2.2'
gem 'omniauth-github', '~> 1.1.2'

gem 'jquery-rails', '~> 4.0.5'
gem 'turbolinks', '~> 2.5.3'
gem 'jquery-turbolinks', '~> 2.1.0'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.3.2'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.1',          group: :doc

gem 'squeel', '~> 1.2.3'

gem 'activeadmin', github: 'gregbell/active_admin'

gem 'simple_form', github: 'plataformatec/simple_form'
gem 'friendly_id', '~> 5.1.0'

# gem 'cancancan', '~> 1.13.1'
gem 'pundit'

gem 'unicorn'
gem 'foreman'

## API

# Assets
gem 'bootstrap-sass', '~> 3.3.5.1'
source 'https://rails-assets.org' do
  gem 'rails-assets-bootswatch-scss', '~> 3.2.0.3'
end
gem 'font-awesome-sass', '~> 4.4.0'

## Faye
# gem 'faye-websocket'
gem 'pusher'
gem 'vuejs-rails'

gem 'sqlite3'
group :development do
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
  gem 'rspec-rails'
  gem 'database_cleaner'
  gem 'capybara'
  gem 'factory_girl_rails'
end

group :production, :staging do
  gem 'pg'
end

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'


# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development



# Use debugger
# gem 'debugger', group: [:development, :test]

