FROM ruby:2.7
MAINTAINER iBug <docker@ibugone.com>

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get -y update && \
    apt-get -y install --no-install-recommends nodejs default-mysql-client && \
    apt-get -y autoremove && \
    apt-get -y autoclean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app
ADD Gemfile Gemfile.lock /app/
RUN bundle install --deployment --without development test
ADD . /app
ENV RAILS_ENV=production RAILS_SERVE_STATIC_FILES=true
EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "--environment=production", "--no-daemon", "--log-to-stdout"]
