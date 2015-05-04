#!/bin/bash
set -e
source /build/buildconfig
set -x

## See https://www.vultr.com/docs/use-php5-fpm-with-apache-2-on-ubuntu-14-04
$minimal_apt_get_install apache2-mpm-event

## Adding Trusty Multiverse repos
cp /build/config/apt/trusty-multiverse.list /etc/apt/sources.list.d/ && apt-get -qy update

$minimal_apt_get_install libapache2-mod-fastcgi

a2enmod actions fastcgi alias rewrite

# we want www-data to have uid of 1000 so it would retain write access to /var/www should this be
# exposed as a "volume"
userdel www-data && useradd -d /var/www -u 1000 -M www-data

cp -Rfv /build/config/apache2/ /etc/

echo "ServerName localhost" >> /etc/apache2/apache2.conf