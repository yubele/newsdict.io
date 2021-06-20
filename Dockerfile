# Define base image, you can use --build-arg
ARG base_image="newsdict/rails:ubuntu20.10_nvmv0.37.0_nodev15.2.1_rubyv3.0.0_sasscv2.4.0_ffiv1.13.1_chromedriver"
FROM $base_image

# Set locale
ENV LANG "C.UTF-8"
ENV NOKOGIRI_USE_SYSTEM_LIBRARIES "YES"

# Set correct environment variables.
RUN mkdir -p /var/www/docker
WORKDIR /var/www/docker

# Set up application
COPY . .
RUN cp src/provisioning/nginx/sites-available/default /etc/nginx/sites-available/default
RUN cp -r src/provisioning/startup /startup

# Init gems
RUN echo "gem: --no-rdoc --no-ri" > ~/.gemrc
RUN . /etc/profile.d/rvm.sh && \
  bundle config without 'development test' && \
  bundle config system true && \
  bundle config jobs 10 && \
  bundle config build.nokogiri --use-system-libraries && \
  bundle install && \
  bundle config frozen true

# If you are running the development environment, the pid file will remain, so delete the pid file
RUN if [ -f /var/www/docker/tmp/pids/server.pid ]; then \
        rm /var/www/docker/tmp/pids/server.pid; \
    fi

# Clean assets
RUN rm -rf public/packs/* public/assets/*

CMD ["bash", "/startup/web/startup.sh", "production"]

# Port 3000: puma
# Port 80: document server
# Port 3035: webpack-dev-server
EXPOSE 80 8080 3035