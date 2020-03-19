# newsdict
Correct the conntents from Internet.

# Settings

1. copy `.env-sample` file to `.env` file.
2. Edit `.env`.

# Development Tools
Newsdict use docker-compse on development env.

## Build
    $ docker-compose build

## Start the containers.
    $ docker/start

### Build and start.
    $ docker/start --build
    
### Start a container

    $ docker/start (web|worker|document)

## rails comamnds
sample ex)

    $ docker/rails -T
    $ docker/rails test -v

## bundle comamnds
sample ex)

    $ docker/bundle exec ruby -v

## shell exec
    $ docker/bash
    
## Secret
    $ EDITOR="mate --wait" bin/rails credentials:edit
    
# functions

## Mecab

### Update mecab dic
1. Add Configs::MecabDic on /admin/configs~mecab_dic