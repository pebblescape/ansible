#!/bin/bash

exec 2>&1
set -e
set -x

sed -i 's/^#\s*\(deb.*universe\)$/\1/g' /etc/apt/sources.list
sed -i 's/^#\s*\(deb.*multiverse\)$/\1/g' /etc/apt/sources.list
echo deb http://ppa.launchpad.net/brightbox/ruby-ng/ubuntu trusty main > /etc/apt/sources.list.d/ppa_brightbox_ruby_ng_trusty.list
apt-get update

apt-get install -y --force-yes --no-install-recommends linux-image-extra-`uname -r` libxml2-dev ruby2.2
apt-get -y remove ruby1.8
gem update --system
gem install bundler

## jemalloc
mkdir /tmp/jemalloc && cd /tmp/jemalloc
wget http://www.canonware.com/download/jemalloc/jemalloc-3.4.1.tar.bz2
tar -xvjf jemalloc-3.4.1.tar.bz2 && cd jemalloc-3.4.1 && ./configure && make
mv lib/libjemalloc.so.1 /usr/lib && cd / && rm -rf /tmp/jemalloc

rm -rf /tmp/jemalloc