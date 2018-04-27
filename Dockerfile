FROM ubuntu:16.04

MAINTAINER Min Kim <minskim@pkgsrc.org>

RUN \
  apt-get update && \
  apt-get install -y \
    curl \
    gcc

ENV \
    gitref=trunk \
    packages=/mnt/packages

CMD \
  curl -L https://api.github.com/repos/NetBSD/pkgsrc/tarball/${gitref} | \
    tar -zxf - -C /usr && \
  mv /usr/NetBSD-pkgsrc-* /usr/pkgsrc && \
  cd /usr/pkgsrc/bootstrap && \
  if [ -f ${packages}/bootstrap.tar.gz ]; then \
    mv -f ${packages}/bootstrap.tar.gz ${packages}/bootstrap.old.tar.gz; \
  fi && \
  env SH=/bin/bash ./bootstrap --gzip-binary-kit ${packages}/bootstrap.tar.gz && \
  ./cleanup
