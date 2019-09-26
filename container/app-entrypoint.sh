#!/bin/bash -e

. /opt/bitnami/base/functions
. /opt/bitnami/base/helpers

print_welcome_page

if [[ "$1" == "nami" && "$2" == "start" ]] || [[ "$1" == "/init.sh" ]]; then
  . /mediawiki-init.sh
  nami_initialize apache php mysql-client mediawiki
  sed -i 's/^\$wgDefaultSkin.*$//g' /bitnami/mediawiki/LocalSettings.php
  sed -i 's/^wfLoadSkin.*$//g' /bitnami/mediawiki/LocalSettings.php
  echo >> /bitnami/mediawiki/LocalSettings.php
  echo "# wiki.dave.io additional config" >> /bitnami/mediawiki/LocalSettings.php
  echo >> /bitnami/mediawiki/LocalSettings.php
  cat /additional-config.php >> /bitnami/mediawiki/LocalSettings.php
  (
    cd /opt/bitnami/mediawiki
    composer update
  )
  info "Starting mediawiki... "
fi

exec tini -- "$@"
