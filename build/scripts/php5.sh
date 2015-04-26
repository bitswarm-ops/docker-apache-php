#!/bin/bash
set -e
source /build/buildconfig
set -x

## Installing PHP5
$minimal_apt_get_install libapache2-mod-fastcgi php5-fpm php5

## PHP5 Extras
$minimal_apt_get_install \
    php5-cli \
    php5-mysql \
    php5-sqlite \
    php5-gd \
    php5-curl \
    php-pear \
    php5-json \
    php5-xmlrpc \
    php5-xsl \
    php5-intl \
    php-apc

#a2enconf php5-fpm
# Overlaying our own configuration onto /etc/php5
cp -Rfv /build/config/php5 /etc/

# this will be picked up by /etc/my_init.d/40_xdebug.sh and dropped over the default installed one when
# XDEBUG_ENABLED==1
mv /etc/php5/mods-available/xdebug.ini /root/

sed -i "s/variables_order.*/variables_order = \"EGPCS\"/g" /etc/php5/fpm/php.ini
