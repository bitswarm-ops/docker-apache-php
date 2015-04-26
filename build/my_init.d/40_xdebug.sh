#!/bin/bash
set -e

if [ $XDEBUG_ENABLED -eq 1 ]; then
  echo "#### PHP XDebug enabled"
  if [  ! -e /usr/lib/php5/20121212/xdebug.so ]; then
    rm -f /etc/php5/mods-available/xdebug.ini

    echo "#### php5-xdebug doesn't appear installed, installing now"
    ( export LC_ALL=C; \
      export DEBIAN_FRONTEND=noninteractive; \
      apt-get update && \
      apt-get install -y --no-install-recommends php5-xdebug && \
      apt-get clean )
    rm -rf /tmp/* /var/tmp/*
    rm -rf /var/lib/apt/lists/*

    if [ -e /root/xdebug.ini ]; then
      echo "#### Applying our xdebug.ini"
      mv -f /root/xdebug.ini /etc/php5/mods-available/
    fi

    echo "#### PHP XDebug installed"
  else
    echo "#### PHP XDebug already installed, not uninstalling"
  fi

  cd /etc/php5/cli/conf.d
  ln -sf ../../mods-available/xdebug.ini 20-xdebug.ini
  cd /etc/php5/fpm/conf.d
  ln -sf ../../mods-available/xdebug.ini 20-xdebug.ini
else
  echo "#### PHP XDebug disabled"
  rm -f /etc/php5/cli/conf.d/20-xdebug.ini
  rm -f /etc/php5/fpm/conf.d/20-xdebug.ini
fi

exit