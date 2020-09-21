#!/bin/bash
bundle exec rake app:update:bin
bundle exec rails webpacker:binstubs
bundle exec spring binstub --all