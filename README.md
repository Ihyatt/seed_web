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

Contributing
------------

-   Create a branch with the issue name
For example if the Issue is 134 Add Views Count To Invites

```
git checkout -b 134_add_views_count
```

-   Write a test case to for your issue
-   Make the minimal amount of code to make your test pass
-   Refactor
-   Write comments on any method longer than 5 lines
-   Favor readability over terse code (Don't be too clever)
-   Verify all tests pass. Guard should always be running or
```
rspec spec
```

-   Commit your code and do a pull requests. Only when all tests pass will it be accepted
-   Favor small multiple commits over large ones

* Services (job queues, cache servers, search engines, etc.)
Sidekiq handles all background jobs and mailers


* Deployment instructions
```
git push production master && heroku run rake db:migrate -r production
```

* Push Branch
```
git push production +HEAD:master && heroku run rake db:migrate -r production
```

