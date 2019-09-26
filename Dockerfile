FROM bitnami/mediawiki:1.33.0-debian-9-r84
ENV DEBIAN_FRONTEND=noninteractive
RUN install_packages imagemagick \
    && apt-get update \
    && apt-get install -y apt-utils \
    && apt-get install -y unzip
COPY theme /bitnami/mediawiki/skins/chameleon
COPY container/composer.json /opt/bitnami/mediawiki/composer.json
COPY container/composer.local.json /opt/bitnami/mediawiki/composer.local.json
COPY container/app-entrypoint.sh /app-entrypoint.sh
