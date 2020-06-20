FROM ruby:2.7
MAINTAINER iBug <docker@ibugone.com>

WORKDIR /app
ADD Gemfile Gemfile.lock /app/
RUN bundle install --deployment --without development test
ADD . /app
ENV RAILS_ENV=production
EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "--environment=production", "--no-daemon", "--log-to-stdout"]
