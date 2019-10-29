FROM ubuntu:19.10

MAINTAINER Min Kim <minskim@pkgsrc.org>

COPY pkgsrc-bootstrap.conf /etc/

RUN \
  apt-get update && \
  apt-get install -y \
    clang \
    curl \
    libssl-dev

ENV \
    BOOTSTRAP_MAKE_JOBS=1 \
    PKGSRC_MAKE_JOBS=1 \
    gitref=trunk \
    packages=/packages

CMD \
  curl -L https://api.github.com/repos/NetBSD/pkgsrc/tarball/${gitref} | \
    tar -zxf - -C /usr && \
  mv /usr/NetBSD-pkgsrc-* /usr/pkgsrc && \
  cd /usr/pkgsrc/bootstrap && \
  if [ -f ${packages}/bootstrap.tar.gz ]; then \
    mv -f ${packages}/bootstrap.tar.gz ${packages}/bootstrap.old.tar.gz; \
  fi && \
  echo "\nMAKE_JOBS?=	${PKGSRC_MAKE_JOBS}" >> /etc/pkgsrc-bootstrap.conf && \
  env CC=clang SH=/bin/bash ./bootstrap \
    --compiler clang \
    --gzip-binary-kit ${packages}/bootstrap.tar.gz \
    --make-jobs ${BOOTSTRAP_MAKE_JOBS} \
    --mk-fragment /etc/pkgsrc-bootstrap.conf && \
  ./cleanup
