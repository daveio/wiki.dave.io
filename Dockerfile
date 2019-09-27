FROM bitnami/mediawiki:1.33.0-debian-9-r84
ENV DEBIAN_FRONTEND=noninteractive
RUN install_packages imagemagick \
    && apt-get update \
    && apt-get install -y apt-utils \
    && apt-get install -y unzip
COPY theme /theme
COPY extensions /extensions
COPY container/composer.json /composer.json
COPY container/composer.local.json /composer.local.json
COPY container/app-entrypoint.sh /app-entrypoint.sh
COPY container/additional-config.php /additional-config.php
