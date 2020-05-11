FROM ubuntu:18.04

## Have to use this due to default interactive tzdata config
ARG DEBIAN_FRONTEND=noninteractive

ENV BOSH_VERSION 6.2.1
ENV BOSH_URL https://s3.amazonaws.com/bosh-cli-artifacts/bosh-cli-${BOSH_VERSION}-linux-amd64

ENV YQ_VERSION 3.3.0
ENV YQ_URL https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_amd64

ENV PACKAGES "openssl openssh-client wget curl jq sshpass rsync make tzdata ca-certificates \
build-essential zlibc zlib1g-dev ruby ruby-dev libxslt-dev libxml2-dev libssl-dev \
libreadline-dev libyaml-dev libsqlite3-dev sqlite3 git vim"

RUN apt-get update && apt-get -y upgrade && apt-get install -y --no-install-recommends ${PACKAGES} && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN curl -fL ${BOSH_URL} -o bosh && chmod +x bosh && mv bosh /usr/local/bin/bosh
RUN curl -fL ${YQ_URL} -o yq && chmod +x yq && mv yq /usr/local/bin/yq && ln -s /usr/local/bin/yq /usr/local/bin/yaml
