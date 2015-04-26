#!/bin/bash
set -e
source /build/buildconfig
set -x

## Often used tools.
$minimal_apt_get_install curl wget less nano vim man rlwrap lsb-release rsync
