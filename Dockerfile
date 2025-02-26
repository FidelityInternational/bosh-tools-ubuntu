FROM ubuntu:22.04

## Have to use this due to default interactive tzdata config
ARG DEBIAN_FRONTEND=noninteractive

ENV BOSH_VERSION="7.8.6"
ENV YQ_VERSION="4.26.1"
ENV PACKAGES "openssl openssh-client wget curl jq sshpass rsync make tzdata ca-certificates \
build-essential zlib1g-dev ruby ruby-dev libxslt-dev libxml2-dev libssl-dev  \
libreadline-dev libyaml-dev libsqlite3-dev sqlite3 git vim"

RUN apt-get update && apt-get -y upgrade && apt-get install -y --no-install-recommends ${PACKAGES} && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN curl -fL "https://github.com/mikefarah/yq/releases/download/v${YQ_VERSION}/yq_linux_amd64" -o /usr/local/bin/yq
RUN curl -fL "https://github.com/cloudfoundry/bosh-cli/releases/download/v${BOSH_VERSION}/bosh-cli-${BOSH_VERSION}-linux-amd64" -o /usr/local/bin/bosh
RUN chmod +x /usr/local/bin/*
