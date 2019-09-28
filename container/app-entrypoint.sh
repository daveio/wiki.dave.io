#!/bin/bash -e

. /opt/bitnami/base/functions
. /opt/bitnami/base/helpers

print_welcome_page

if [[ "$1" == "nami" && "$2" == "start" ]] || [[ "$1" == "/init.sh" ]]; then
  cp /composer.json /opt/bitnami/mediawiki/composer.json
  cp /composer.local.json /opt/bitnami/mediawiki/composer.local.json
  if [[ ! -d /bitnami/mediawiki/skins ]]; then
    mkdir -p /bitnami/mediawiki/skins
  fi
  if [[ ! -d /bitnami/mediawiki/extensions ]]; then
    mkdir -p /bitnami/mediawiki/extensions
  fi
  cp -r /theme /bitnami/mediawiki/skins/chameleon
  cp -r /extensions/* /bitnami/mediawiki/extensions/
  chmod a+x /bitnami/mediawiki/extensions/Scribunto/includes/engines/LuaStandalone/binaries/lua5_1_5_linux_64_generic/lua
  (
    cd /opt/bitnami/mediawiki
    composer update
  )
  for i in /bitnami/mediawiki/extensions/*; do
    (
      cd $i
      composer update
    )
  done
  # upstream
  . /mediawiki-init.sh
  nami_initialize apache php mysql-client mediawiki
  # /upstream
  sed -i 's/^\$wgDefaultSkin.*$//g' /bitnami/mediawiki/LocalSettings.php
  sed -i 's/^wfLoadSkin.*$//g' /bitnami/mediawiki/LocalSettings.php
  sed -i 's/^\$wgMetaNamespace.*$//g' /bitnami/mediawiki/LocalSettings.php
  echo >> /bitnami/mediawiki/LocalSettings.php
  echo "# wiki.dave.io additional config" >> /bitnami/mediawiki/LocalSettings.php
  echo >> /bitnami/mediawiki/LocalSettings.php
  cat /additional-config.php >> /bitnami/mediawiki/LocalSettings.php
  cp /composer.json /opt/bitnami/mediawiki/composer.json
  cp /composer.local.json /opt/bitnami/mediawiki/composer.local.json
  cp -r /theme /bitnami/mediawiki/skins/chameleon
  cp -r /extensions/* /bitnami/mediawiki/extensions/
  chmod a+x /bitnami/mediawiki/extensions/Scribunto/includes/engines/LuaStandalone/binaries/lua5_1_5_linux_64_generic/lua
  (
    cd /opt/bitnami/mediawiki
    composer update
  )
  for i in /bitnami/mediawiki/extensions/*; do
    (
      cd $i
      composer update
    )
  done
  php /opt/bitnami/mediawiki/maintenance/update.php --quick
  php /opt/bitnami/mediawiki/maintenance/rebuildall.php
  info "Starting mediawiki... "
fi

exec tini -- "$@"
