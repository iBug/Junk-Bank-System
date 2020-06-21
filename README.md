# Junk Bank System

No, this is not really a bank system. It's the 3rd lab of « Database Systems » of USTC in Spring 2020.

## Quick start

If you have [Docker Compose installed](https://docs.docker.com/compose/install/), then you can get this project running easily with [docker-compose.yml](docker-compose.yml) provided in this repository.

You can also pull the image and run it manually:

```shell
docker pull ibugone/junk-bank-system
docker run --rm --name=jbs \
  -e DATABASE_HOST=127.0.0.1 \
  -e DATABASE_PORT=3306 \
  -e DATABASE_NAME=junk_bank \
  -e DATABASE_USER=junk_bank \
  -e DATABASE_PASSWORD=junk_bank \
  ibugone/junk-bank-system
```

Make sure your database information is correct.

### Database seeding

It's recommended that you load the provided seed into the database. To do this with Docker, using the following command:

```shell
docker exec <container name> bundle exec rake db:seed
```

The name of the container may vary depending on how you spun it up, for example `jbs` or `junk-bank-system_app_1`. Find the correct container for yourself, which should be based on the image `ibugone/junk-bank-system:latest` or similar.

## Manual setup

### Environment

Development and testing was done using stock [Ruby 2.7.0p0 in Ubuntu Focal][ruby-focal] and Rails 6.0 (provided in `Gemfile.lock`). Theoretically Ruby 2.5 to 2.7 should all work so feel free to use whichever is available.

Windows and macOS are **not** tested so please prepare for possible problems when running on these platforms.

### Install dependencies

Assume you have Ruby `ruby` and RubyGems `gem` installed, get [Bundler][bundler] with `gem install bundler`. Then install dependencies from `Gemfile` with

```shell
bundle install --path=vendor/bundle
```

### Initialize database

Edit `config/database.yml` properly and then initialize the database with the following commands:

```shell
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:seed
```

You can also combine the above commands into one:

```shell
bundle exec rake db:setup
```

### Start development server

```shell
bundle exec rails server
```

Then visit <http://127.0.0.1:3000/> to see this application in action.

### Start production server

Production environment is mostly the same, except you have to initialize the database again.

```shell
export RAILS_ENV=production
bundle exec rake db:setup
bundle exec rails server --port=3333  # Change port number to whatever you want
```

And then you can configure Nginx or Apache2 as a reverse proxy.


  [ruby-focal]: https://packages.ubuntu.com/focal/ruby
  [bundler]: https://bundler.io/
