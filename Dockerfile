############################################################
# Dockerfile to develop using Dart.
# - Dart VM
# - Flutter
# - AngularDart
############################################################
FROM debian:stretch
LABEL maintainer="Luong Bui"

RUN apt-get update && apt-get -y install vim nano
 
