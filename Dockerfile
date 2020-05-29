# Define base image, you can use --build-arg
ARG base_image="newsdict/rails:ubuntu20.10_nvmv0.35.2_nodev13.9.0_rubyv2.7.0_sasscv2.3.0_ffiv1.12.2_chromedriver"
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
  bundle config --global without 'development test' && \
  bundle config --global system true && \
  bundle config --global jobs 10 && \
  bundle config --global build.nokogiri --use-system-libraries && \
  bundle install&& \
  bundle config --global frozen true

# Recreate bins. It only run on web server and production.
RUN . /etc/profile.d/rvm.sh && \
    . $HOME/.nvm/nvm.sh && \
    rm -rf /var/www/docker/bin && \
    bundle exec rake app:update:bin

# If you are running the development environment, the pid file will remain, so delete the pid file
RUN if [ -f /var/www/docker/tmp/pids/server.pid ]; then \
        rm /var/www/docker/tmp/pids/server.pid; \
    fi

# Clean assets
RUN rm -rf public/packs/* public/assets/*

CMD ["bash", "/startup/web/startup.sh", "production"]

# Port 80: Application (nginx + puma)
# Port 3035: webpack-dev-server
EXPOSE 80 3035