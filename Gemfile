source 'https://rubygems.org'
ruby '2.3.1'

gem 'dotenv-rails'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'

gem 'haml-rails', '~> 0.9'
gem 'haml'
gem 'devise'
gem 'bootstrap', '~> 4.0.0.alpha3.1'
gem 'rolify'
gem 'friendly_id', '~> 5.1.0'
gem 'redis', '~>3.2'
gem 'sidekiq'
gem 'rack-protection', github: 'sinatra/rack-protection', require: false
gem 'sinatra', github: 'sinatra', require: false
gem 'active_model_serializers', '~> 0.10.0'
gem 'apitome'
gem 'kaminari'
gem 'pundit'
gem 'cocoon'
gem 'geocoder'
gem 'acts-as-taggable-array-on', :github => 'kidbombay/acts-as-taggable-array-on'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'rspec-rails'
  gem 'guard'
  gem 'guard-bundler', require: false
  gem 'guard-rspec', require: false
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'rspec_api_documentation'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'spring-commands-rspec'
  gem 'terminal-notifier-guard', '~> 1.6.1'
end

group :test do
  gem 'capybara'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'database_cleaner'
  gem 'pundit-matchers', '~> 1.1.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
