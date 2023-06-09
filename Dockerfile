# syntax=docker/dockerfile:experimental
FROM centos:centos7

RUN --mount=type=bind,target=/mnt,source=mnt,ro \
    /mnt/build.sh

# Environment Configuration
ENV CC=/opt/rh/devtoolset-12/root/usr/bin/gcc \
    CPP=/opt/rh/devtoolset-12/root/usr/bin/cpp \
    CXX=/opt/rh/devtoolset-12/root/usr/bin/g++ \
    PATH=/opt/rh/devtoolset-12/root/usr/bin:/opt/rh/llvm-toolset-13.0/root/usr/bin:/opt/rh/llvm-toolset-13.0/root/usr/sbin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
    LD_LIBRARY_PATH=/opt/rh/devtoolset-12/root/usr/lib64:/opt/rh/devtoolset-12/root/usr/lib:/opt/rh/devtoolset-12/root/usr/lib64/dyninst:/opt/rh/devtoolset-12/root/usr/lib/dyninst:/opt/rh/llvm-toolset-13.0/root/usr/lib64 \
    MANPATH=/opt/rh/devtoolset-12/root/usr/share/man:/opt/rh/llvm-toolset-13.0/root/usr/share/man \
    PKG_CONFIG_PATH=/opt/rh/devtoolset-12/root/usr/lib64/pkgconfig:/opt/rh/llvm-toolset-13.0/root/usr/lib64/pkgconfig \
    INFOPATH=/opt/rh/devtoolset-12/root/usr/share/info \
    X_SCLS='devtoolset-12 llvm-toolset-13.0' \
    PCP_DIR=/opt/rh/devtoolset-12/root \
    VSCODE=1 \
    WALLARM_STATIC=true

USER vscode
