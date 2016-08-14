# README

1. Clone to local
2. cd seed_web
3. Install dependencies listed below
4. Copy .env.example to .env

```
bundle install
bundle exec spring binstub --all
rake db:create
rake db:migrate
rake db:seed
```

Starts the server and guard to run rspec
```
foreman start -f Procfile.dev
```
Open http://localhost:3000/

* Ruby version 2.3.1

* System dependencies
Postgres
Sidekiq
Redis

* Local dependencies
Postgres - http://postgresapp.com/
Homebrew
RVM - https://rvm.io/
ImageMagick 
Terminal Notifier
Foreman

```
brew install redis
brew install terminal-notifier
brew install imagemagick
gem install foreman
```


* Configuration

Copy .env.example to .env

* Database creation

```
rake db:create
```

* Database initialization

* How to run the test suite

```
rspec
```

* Update API Docs
```
rake docs:generate
```

* Services (job queues, cache servers, search engines, etc.)
Sidekiq handles all background jobs and mailers


* Deployment instructions
git push heroku && heroku run rake db:migrate --app seed-web

