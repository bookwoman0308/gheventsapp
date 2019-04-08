FROM ruby:2.5

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs postgresql-client

RUN mkdir /gheventsapp
WORKDIR /gheventsapp

ADD Gemfile /gheventsapp/Gemfile
ADD Gemfile.lock /gheventsapp/Gemfile.lock

RUN bundle install

ADD . /gheventsapp
