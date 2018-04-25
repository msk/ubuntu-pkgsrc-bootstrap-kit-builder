FROM ubuntu:latest

MAINTAINER Min Kim <minskim@pkgsrc.org>

RUN \
  apt-get update && \
  apt-get install -y \
    gcc \
    git

ENV \
    branch=trunk \
    packages=/mnt/packages

CMD \
  cd /usr && \
  git clone -b ${branch} \
    --depth 1 https://github.com/NetBSD/pkgsrc.git && \
  cd pkgsrc/bootstrap && \
  env SH=/bin/bash ./bootstrap --gzip-binary-kit ${packages}/bootstrap.tar.gz && \
  ./cleanup
