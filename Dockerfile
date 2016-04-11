FROM alpine:3.3
MAINTAINER Christopher Sexton <chris@radiusnetworks.com>

ENV RUBY_VERSION 2.3.0
ENV RUBY_DOWNLOAD_SHA256 ba5ba60e5f1aa21b4ef8e9bf35b9ddb57286cb546aac4b5a28c71f459467e507

ENV RAILS_ENV=production

ENV BASE_PACKAGES bash curl gmp git
ENV BUILD_PACKAGES build-base libc-dev linux-headers openssl-dev postgresql-dev libxml2-dev libxslt-dev readline-dev

EXPOSE 3000

RUN apk update && \
    apk upgrade && \
    apk add $BASE_PACKAGES && \
    rm -rf "/var/cache/apk/*"

RUN apk --update add --virtual build_deps $BUILD_PACKAGES && \
    cd "/tmp" && \
    curl -L "https://cache.ruby-lang.org/pub/ruby/2.3/ruby-2.3.0.tar.gz" -o ruby.tar.gz && \
    tar -xzf ruby.tar.gz && \
    rm ruby.tar.gz && \
    cd "/tmp/ruby-2.3.0" && \
    ./configure --disable-install-doc && \
    make && \
    make install && \
    rm -rf "/tmp/ruby-2.3.0" && \
    rm -rf "/var/cache/apk/*"

RUN echo "---" > /etc/gemrc && \
    echo ":update_sources: true" >> /etc/gemrc && \
    echo ":verbose: true" >> /etc/gemrc && \
    echo ":backtrace: false" >> /etc/gemrc && \
    echo ":benchmark: false" >> /etc/gemrc && \
    echo "gem: --no-document" >> /etc/gemrc

