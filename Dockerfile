# define newsdict/rails version, you can use --build-arg
ARG version="v0.0.3"
FROM newsdict/rails:${version}

# Set correct environment variables.
RUN mkdir -p /var/www/docker
WORKDIR /var/www/docker

# Set up application
COPY . .
COPY src/provisioning/nginx/sites-available/default /etc/nginx/sites-available/default
COPY src/provisioning/startup /startup

# If you are running the development environment, the pid file will remain, so delete the pid file
RUN if [ -f /var/www/docker/tmp/pids/server.pid ]; then \
        rm /var/www/docker/tmp/pids/server.pid; \
    fi
    
CMD ["bash", "/startup/web/startup.sh", "production"]

# Port 80: Application (nginx + puma)
# Port 8080: Document (yard + asciidoctor)
# Port 3036: webpack-dev-server
EXPOSE 80 8080 3036