FROM ubuntu:latest

MAINTAINER Min Kim <minskim@pkgsrc.org>

RUN \
  apt-get update && \
  apt-get install -y \
    gcc \
    git

ENV \
    GZIP_BINARY_KIT=/usr/pkgsrc/packages/bootstrap.tar.gz \
    PKGSRC_BRANCH=trunk

CMD \
  cd /usr && \
  git clone -b ${PKGSRC_BRANCH} \
    --depth 1 https://github.com/NetBSD/pkgsrc.git && \
  cd pkgsrc/bootstrap && \
  env SH=/bin/bash ./bootstrap --gzip-binary-kit ${GZIP_BINARY_KIT} && \
  ./cleanup
