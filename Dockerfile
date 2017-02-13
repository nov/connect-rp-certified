FROM ruby:2.4.0
RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /app
WORKDIR /app
ADD Gemfile .
ADD Gemfile.lock .
ENV BUNDLE_JOBS=4 \
    BUNDLE_PATH=/bundle
RUN bundle install
ADD . .