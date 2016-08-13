# README

1. Clone to local
2. cd seed_web
3. bundle install
4. Copy .env.example to .env
5. rake db:create
6. rake db:seed
7. foreman start -f Procfile.dev

Starts the server and guard to run rspec


* Ruby version 2.3.1

* System dependencies

Postgres

* Local dependencies

RVM
ImageMagick
Redis

```
gem install foreman
```

```
brew install terminal-notifier
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

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

