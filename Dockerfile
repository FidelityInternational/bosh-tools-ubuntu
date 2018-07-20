FROM ubuntu:18.04

## Have to use this due to default interactive tzdata config
ARG DEBIAN_FRONTEND=noninteractive

ENV BOSH2_VERSION 2.0.48
ENV BOSH2_URL https://s3.amazonaws.com/bosh-cli-artifacts/bosh-cli-${BOSH2_VERSION}-linux-amd64
ENV BOSH2_PACKAGES "openssl openssh-client wget curl jq sshpass rsync make tzdata ca-certificates \
    build-essential zlibc zlib1g-dev ruby ruby-dev libxslt-dev libxml2-dev libssl-dev libreadline6 \
    libreadline6-dev libyaml-dev libsqlite3-dev sqlite3"

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install -y --no-install-recommends ${BOSH2_PACKAGES}

RUN wget -q -O /usr/local/bin/bosh --no-check-certificate ${BOSH2_URL}
RUN chmod +x /usr/local/bin/bosh

RUN curl -L https://github.com/mikefarah/yq/releases/download/1.14.0/yq_linux_amd64 -o yq && chmod +x yq && mv yq /usr/local/bin/yq
RUN ln -s /usr/local/bin/yq /usr/local/bin/yaml

RUN apt-get clean

RUN rm -rf /var/lib/apt/lists/*
