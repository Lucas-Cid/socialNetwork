#!/bin/bash
echo "" > Gemfile.lock

sudo docker-compose build

sudo docker-compose run web rake db:create

sudo docker-compose run web rake db:migrate 