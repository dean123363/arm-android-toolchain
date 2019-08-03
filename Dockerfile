FROM ubuntu:16.04
LABEL maintainer="Alvis Zhao<alvisisme@gmail.com>"
RUN sed -i "s/archive.ubuntu.com/mirrors.163.com/g" /etc/apt/sources.list && \
    sed -i "s/security.ubuntu.com/mirrors.163.com/g" /etc/apt/sources.list

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install unzip wget python

ENV ANDROID_NDK_VERSION r13b

RUN wget -q https://dl.google.com/android/repository/android-ndk-${ANDROID_NDK_VERSION}-linux-x86_64.zip && \
    unzip -qq android-ndk-${ANDROID_NDK_VERSION}-linux-x86_64.zip && \
    /bin/bash android-ndk-${ANDROID_NDK_VERSION}/build/tools/make-standalone-toolchain.sh --arch=arm \
    --platform=android-21 --toolchain=arm-linux-androideabi-4.9 --stl=libc++ --install-dir=/opt/arm-android-toolchain && \
    rm -rf android-ndk-${ANDROID_NDK_VERSION}-linux-x86_64.zip && \
    rm -rf android-ndk-${ANDROID_NDK_VERSION}

ENV PATH=$PATH:/opt/arm-android-toolchain/bin
ENV CC=/opt/arm-android-toolchain/bin/arm-linux-androideabi-gcc
ENV CXX=/opt/arm-android-toolchain/bin/arm-linux-androideabi-g++
ENV LINK=/opt/arm-android-toolchain/bin/arm-linux-androideabi-g++
ENV LD=/opt/arm-android-toolchain/bin/arm-linux-androideabi-ld
ENV AR=/opt/arm-android-toolchain/bin/arm-linux-androideabi-ar
ENV RANLIB=/opt/arm-android-toolchain/bin/arm-linux-androideabi-ranlib
ENV STRIP=/opt/arm-android-toolchain/bin/arm-linux-androideabi-strip
ENV OBJCOPY=/opt/arm-android-toolchain/bin/arm-linux-androideabi-objcopy
ENV OBJDUMP=/opt/arm-android-toolchain/bin/arm-linux-androideabi-objdump
ENV NM=/opt/arm-android-toolchain/bin/arm-linux-androideabi-nm
ENV AS=/opt/arm-android-toolchain/bin/arm-linux-androideabi-as
ENV SYSROOT=/opt/arm-android-toolchain/sysroot
