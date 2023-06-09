#!/bin/bash

set -ex

echo '
[devtoolset-12]
name=Devtoolset 12
baseurl=https://buildlogs.centos.org/c7-devtoolset-12.x86_64/
enabled=1
gpgcheck=0
repo_gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7' | tee -a /etc/yum.repos.d/devtoolset-12.repo

echo '
[llvm-toolset-13]
name=llvm-toolset-13
baseurl=https://buildlogs.centos.org/c7-llvm-toolset-13.0.x86_64/
enabled=1
gpgcheck=0
repo_gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7' | tee -a /etc/yum.repos.d/llvm-toolset-13.repo

yum install -y centos-release-scl epel-release #additional repos
yum -y install https://packages.endpointdev.com/rhel/7/os/x86_64/endpoint-repo.x86_64.rpm

yum install -y devtoolset-12 llvm-toolset-13.0-clang-tools-extra valgrind gdb rr mc tig curl sudo git \
 tcl `#sqlite` \
 CUnit-devel libuuid-devel `#libwacl` \
 re2c `#libdetection` \
 texinfo `#libconfig` \
 valgrind-devel `#gperftools` \
 openssl-devel `#libproton` \
 openssl-static `#libproton proper linking into module`
yum group install -y "Development Tools"

CMAKE_VERSION=3.26.3
curl -L https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}-Linux-x86_64.sh > cmake-${CMAKE_VERSION}-Linux-x86_64.sh && \
sh cmake-${CMAKE_VERSION}-Linux-x86_64.sh --prefix=/usr/local/ --exclude-subdir --skip-license && \
rm cmake-${CMAKE_VERSION}-Linux-x86_64.sh

#groupadd -g ${GROUP_ID} cicd
#useradd -m -l -u ${USER_ID} -G wheel -g cicd cicd
echo '%wheel ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/wheel_group
echo 'Defaults:%wheel !requiretty' >> /etc/sudoers.d/wheel_group

mv -v /usr/bin/install /usr/bin/install-real
cp -v /mnt/install /usr/bin/install
/mnt/entrypoint.sh
tar -xvf /mnt/bear-3.1.2-centos7.tar.xz -C /usr/local

yum -y clean all && rm -rf /var/cache