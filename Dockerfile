FROM abiosoft/caddy:builder as builder
RUN go get -v github.com/abiosoft/parent
RUN GO111MODULE="on" VERSION="1.0.3" PLUGINS="git,cors,realip,expires,cache,cloudflare" ENABLE_TELEMETRY="true" /bin/sh /usr/bin/builder.sh

FROM alpine:latest as fetcher
RUN mkdir /fetch
WORKDIR /fetch
RUN apk add --no-cache wget \
  && wget https://releases.wikimedia.org/mediawiki/1.33/mediawiki-1.33.1.tar.gz \
  && tar xf mediawiki-1.33.1.tar.gz

FROM alpine:latest
LABEL maintainer "Dave Williams <dave@dave.io>"
RUN mkdir /conf
RUN apk add --no-cache \
  bash \
  ca-certificates \
  curl \
  diffutils \
  git \
  imagemagick \
  lua \
  luarocks \
  mailcap \
  nodejs-current \
  npm \
  openssh-client \
  php7-fpm \
  redis \
  librsvg \
  tar \
  tzdata \
  yarn
RUN apk add --no-cache \
  php7-bcmath \
  php7-ctype \
  php7-curl \
  php7-dom \
  php7-exif \
  php7-fileinfo \
  php7-gd \
  php7-iconv \
  php7-intl \
  php7-json \
  php7-mbstring \
  php7-mysqli \
  php7-opcache \
  php7-openssl \
  php7-pcntl \
  php7-pdo \
  php7-pdo_mysql \
  php7-pdo_pgsql \
  php7-pdo_sqlite \
  php7-pecl-apcu \
  php7-pecl-imagick \
  php7-pecl-redis \
  php7-pgsql \
  php7-phar \
  php7-session \
  php7-simplexml \
  php7-sqlite3 \
  php7-tokenizer \
  php7-xml \
  php7-xmlreader \
  php7-xmlwriter \
  php7-zip
RUN ln -sf /usr/bin/php7 /usr/bin/php
RUN ln -sf /usr/bin/php-fpm7 /usr/bin/php-fpm
RUN addgroup -g 1000 www-user && \
  adduser -D -H -u 1000 -G www-user www-user && \
  sed -i "s|^user = .*|user = www-user|g" /etc/php7/php-fpm.d/www.conf && \
  sed -i "s|^group = .*|group = www-user|g" /etc/php7/php-fpm.d/www.conf
RUN curl --silent --show-error --fail --location \
  --header "Accept: application/tar+gzip, application/x-gzip, application/octet-stream" \
  "https://getcomposer.org/installer" \
  | php -- --install-dir=/usr/bin --filename=composer
RUN echo "clear_env = no" >> /etc/php7/php-fpm.conf
COPY --from=builder /go/bin/parent /bin/parent
COPY --from=builder /install/caddy /usr/bin/caddy
COPY --chown=1000:1000 --from=fetcher /fetch/mediawiki-1.33.1 /srv
COPY --chown=1000:1000 index.php /srv/pi.php
COPY Caddyfile /etc/Caddyfile
EXPOSE 80
WORKDIR /srv
VOLUME /conf
# ENTRYPOINT ["/bin/parent", "caddy"]
# CMD ["--conf", "/etc/Caddyfile", "--log", "stdout", "--agree=true"]
# CMD ["/bin/bash"]
CMD ["/usr/bin/caddy", "--conf", "/etc/Caddyfile", "--log", "stdout", "--agree=true"]
