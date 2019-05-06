# newsdict
Correct the conntents from Internet.

# Settings

smtp settings 

1. copy `.env-sample` file to `.env` file.
2. Edit `.env`.

# Development Tools
Newsdict use docker-compse on development env.

## build
    $ sudo docker-compose build

## start docker-compose
    $ docker/start

## rails comamnds
sample ex)

    $ docker/rails -T
    $ docker/rails test -v

## bundle comamnds
sample ex)

    $ docker/bundle exec ruby -v

## shell exec
    $ docker/bash