#!/bin/bash

exec 2>&1
set -e
set -x

echo 'gem: --no-document' >> /usr/local/etc/gemrc
mkdir /tmp/rubysrc && cd /tmp/rubysrc && git clone https://github.com/sstephenson/ruby-build.git
cd /tmp/rubysrc/ruby-build && ./install.sh
cd / && rm -rf /tmp/rubysrc/ruby-build
echo install_package "yaml-0.1.6" "http://pyyaml.org/download/libyaml/yaml-0.1.6.tar.gz#5fe00cda18ca5daeb43762b80c38e06e" --if needs_yaml > /tmp/rubysrc/2.1.2.discourse
echo install_package "openssl-1.0.1g" "https://www.openssl.org/source/openssl-1.0.1g.tar.gz#de62b43dfcd858e66a74bee1c834e959" mac_openssl --if has_broken_mac_openssl >> /tmp/rubysrc/2.1.2.discourse
echo install_package "ruby-v_2_1_2_discourse" "https://github.com/SamSaffron/ruby/archive/v_2_1_2_discourse.tar.gz#98741e3cbfd00ae2931b2c0edb0f0698" ldflags_dirs standard verify_openssl >> /tmp/rubysrc/2.1.2.discourse
apt-get -y install ruby bison
ruby-build /tmp/rubysrc/2.1.2.discourse /usr/local
apt-get -y remove ruby1.8
gem update --system
gem install bundler

## jemalloc
mkdir /tmp/jemalloc && cd /tmp/jemalloc
wget http://www.canonware.com/download/jemalloc/jemalloc-3.4.1.tar.bz2
tar -xvjf jemalloc-3.4.1.tar.bz2 && cd jemalloc-3.4.1 && ./configure && make
mv lib/libjemalloc.so.1 /usr/lib && cd / && rm -rf /tmp/jemalloc

rm -rf /tmp/rubysrc /tmp/jemalloc