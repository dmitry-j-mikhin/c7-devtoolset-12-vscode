#!/bin/bash

set -ex

echo "max_parallel_downloads=10" >> /etc/dnf/dnf.conf
echo "fastestmirror=True" >> /etc/dnf/dnf.conf

dnf install -y clang-tools-extra bear \
 gcc g++ make cmake autoconf automake libtool bison flex patch \
 valgrind gdb rr mc tig curl procps \
 sudo git \
 tcl `#sqlite` \
 CUnit-devel libuuid-devel `#libwacl` \
 re2c `#libdetection` \
 texinfo `#libconfig` \
 valgrind-devel `#gperftools` \
 openssl-devel `#libproton` \
 libstdc++-static pcre-devel \
 ruby rubygem-msgpack \
 ruby-devel lcov \
 tcl-devel diffutils which rubygem-rspec \
 readline-devel ncurses-devel libicu-devel libunwind-devel \
 python3.11-devel \
 https://github.com/dmitry-j-mikhin/fedora-openssl-static/releases/download/v3.1.1-4/openssl-static-3.1.1-4.fc39.x86_64.rpm

echo '%wheel ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/wheel_group
echo 'Defaults:%wheel !requiretty' >> /etc/sudoers.d/wheel_group

mv -v /usr/bin/install /usr/bin/install-real
cp -v /tmp/build/install /usr/bin/install
/tmp/build/entrypoint.sh

dnf -y clean all && rm -rf /var/cache
