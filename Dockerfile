# define base image, you can use --build-arg
ARG base_image="newsdict/rails:ubuntu19.10_nvmv0.35.2_nodev12.16.1_rubyv2.7.0"
FROM $base_image

# Set locale
ENV LANG "C.UTF-8"

# Set correct environment variables.
RUN mkdir -p /var/www/docker
WORKDIR /var/www/docker

# Set up application
COPY . .
COPY src/provisioning/nginx/sites-available/default /etc/nginx/sites-available/default
COPY src/provisioning/startup /startup

# Init gems
RUN rm -rf vendor/bundle
RUN . /etc/profile.d/rvm.sh && \
  bundle install --no-deployment && \
  bundle config set without 'development test' && \
  bundle config set frozen 'true' && \
  bundle install

# If you are running the development environment, the pid file will remain, so delete the pid file
RUN if [ -f /var/www/docker/tmp/pids/server.pid ]; then \
        rm /var/www/docker/tmp/pids/server.pid; \
    fi
    
CMD ["bash", "/startup/web/startup.sh", "production"]

# Port 80: Application (nginx + puma)
# Port 8080: Document (yard + asciidoctor)
# Port 3036: webpack-dev-server
EXPOSE 80 8080 3036