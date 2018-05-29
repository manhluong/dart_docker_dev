############################################################
# Dockerfile to develop using Dart.
# - Dart VM
# - Flutter
# - AngularDart
############################################################
FROM debian:stretch
LABEL maintainer="Luong Bui"
SHELL ["/bin/bash", "-c"]

ARG flutter_version=v0.4.4-beta
RUN apt-get update && \
 apt-get -y install apt-transport-https vim git curl zip xz-utils gnupg lib32stdc++ default-jdk \
  rubygems ruby-dev build-essential && \
# Dart
 sh -c 'curl https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_unstable.list > /etc/apt/sources.list.d/dart_unstable.list' && \
 sh -c 'curl https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -' && \
 sh -c 'curl https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list' && \
 apt-get update && \
 apt-get -y install dart && \
# Flutter
 curl -O -J "https://storage.googleapis.com/flutter_infra/releases/beta/linux/flutter_linux_${flutter_version}.tar.xz" && \
 tar xf "flutter_linux_${flutter_version}.tar.xz" && \
 rm "flutter_linux_${flutter_version}.tar.xz" && \
 apt-get clean
ENV PATH="${PATH}:/flutter/bin"

# Android tools
ARG android_platform_version=android-27
ARG android_build_tools_version=26.0.3
WORKDIR android-sdk
RUN curl -O -J "https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip" && \
 unzip sdk-tools-linux-3859397.zip && \
 rm sdk-tools-linux-3859397.zip && \
 yes | ./tools/bin/sdkmanager --licenses && \
 ./tools/bin/sdkmanager --update && \
 ./tools/bin/sdkmanager "platform-tools" \
  "build-tools;${android_build_tools_version}" \
  "platforms;${android_platform_version}" \
  emulator \
  "extras;android;m2repository" \
  "extras;google;m2repository"
ENV PATH="${PATH}:/android-sdk/tools/bin:/android-sdk/platform-tools:/android-sdk/build-tools/${android_build_tools_version}:/android-sdk/emulator"

# Android Virtual Device
ARG android_default_test_image="system-images;android-27;google_apis;x86"
WORKDIR /android-sdk/avd
RUN sdkmanager ${android_default_test_image}
RUN avdmanager create avd -n test_27_x86 -k ${android_default_test_image} -p . --device "pixel" --force

# Fastlane
RUN gem install fastlane -NV

# External volumes entry point to attach projects that exist in the host.
VOLUME /volumes/prj

WORKDIR /

