ARG RUBY_VERSION=3.1.3
FROM ruby:$RUBY_VERSION-slim as base

WORKDIR /sinatra

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .

CMD ["rackup", "--host", "0.0.0.0", "--port", "8080"]
