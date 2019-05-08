# Use phusion/passenger-full as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/passenger-docker/blob/master/Changelog.md for
# a list of version numbers.
FROM phusion/passenger-ruby26:1.0.5

# Set correct environment variables.
RUN mkdir -p /var/www/newsdict
ENV HOME /var/www/newsdict
WORKDIR /var/www/newsdict

# Use baseimage-bash's init process.
CMD ["/sbin/my_init"]

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt update
RUN apt install -y yarn libmecab-dev mecab-ipadic-utf8 libmagickwand-dev openjdk-8-jdk nodejs npm graphicsmagick graphviz
RUN npm install bower -g

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY . .
COPY src/provisioning/nginx/sites-available/default /etc/nginx/sites-available/default

RUN bundle install --path .bundle --deployment --without development test --quiet
EXPOSE 80 3036 8080