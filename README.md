# Junk Bank System

No, this is not really a bank system. It's the 3rd lab of « Database Systems » of USTC in Spring 2020.

## Running

Development and testing was done using stock [Ruby 2.7.0p0 in Ubuntu Focal][ruby-focal] and Rails 6.0.3.1 (provided in `Gemfile.lock`). Theoretically Ruby 2.5 to 2.7 should all work so feel free to use whichever is available.

Windows and macOS are **not** supported so please don't expect anything when running on these platforms.

### Install dependencies

Assume you have Ruby `ruby` and RubyGems `gem` installed, get [Bundler][bundler] with `gem install bundler`. Then install dependencies from `Gemfile` with

```shell
bundle install --path=vendor/bundle
```

### Initialize database

Edit `config/database.yml` properly then

```shell
bundle exec rake db:create
bundle exec rake db:migrate
```

### Start development server

```shell
bundle exec rails server
```

Then visit <http://127.0.0.1:3000/> to see this application in action.


  [ruby-focal]: https://packages.ubuntu.com/focal/ruby
  [bundler]: https://bundler.io/
