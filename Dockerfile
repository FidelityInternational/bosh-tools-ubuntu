FROM ubuntu:18.04

## Have to use this due to default interactive tzdata config
ARG DEBIAN_FRONTEND=noninteractive

ENV BOSH2_VERSION 5.3.1
ENV BOSH2_URL https://s3.amazonaws.com/bosh-cli-artifacts/bosh-cli-${BOSH2_VERSION}-linux-amd64
ENV BOSH2_PACKAGES "openssl openssh-client wget curl jq sshpass rsync make tzdata ca-certificates \
build-essential zlibc zlib1g-dev ruby ruby-dev libxslt-dev libxml2-dev libssl-dev \
libreadline-dev libyaml-dev libsqlite3-dev sqlite3"
ENV YQ_VERSION 2.1.1
ENV YQ_URL https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_amd64

RUN apt-get update && apt-get -y upgrade && apt-get install -y --no-install-recommends ${BOSH2_PACKAGES} && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN wget -q -O /usr/local/bin/bosh --no-check-certificate ${BOSH2_URL} && chmod +x /usr/local/bin/bosh

RUN curl -L ${YQ_URL} -o yq && chmod +x yq && mv yq /usr/local/bin/yq && ln -s /usr/local/bin/yq /usr/local/bin/yaml
