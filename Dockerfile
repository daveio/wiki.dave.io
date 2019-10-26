FROM bitnami/mediawiki:1.33.1-debian-9-r13
ENV DEBIAN_FRONTEND=noninteractive
RUN install_packages imagemagick \
  && apt-get update \
  && apt-get install -y apt-utils \
  && apt-get install -y unzip git
RUN apt-get update && apt-get -y dist-upgrade
COPY theme /theme
COPY extensions /extensions
COPY container/composer.json /composer.json
COPY container/composer.local.json /composer.local.json
COPY container/app-entrypoint.sh /app-entrypoint.sh
COPY container/additional-config.php /additional-config.php
