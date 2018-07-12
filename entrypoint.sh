#!/bin/bash

cd /app

# node modules global install
npm install -g

# bundle global install
source ~/.bash*
bundle install

bundle exec middleman build

bundle exec middleman server

