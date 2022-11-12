#!/bin/sh

git pull
bundle exec rake assets:precompile db:migrate RAILS_ENV=production
sudo service nginx restart
