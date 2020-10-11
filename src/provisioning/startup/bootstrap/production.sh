#!/bin/bash
bundle exec rake app:update:bin
EDITOR="mate --wait" bundle exec rails credentials:edit
bundle exec rails webpacker:binstubs