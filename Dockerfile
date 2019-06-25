FROM ubuntu:19.04
MAINTAINER Doug Goldstein <doug.goldstein@starlab.io>

ENV DEBIAN_FRONTEND=noninteractive
ENV USER root

# build depends
RUN apt-get update && \
    apt-get --quiet --yes install \
        build-essential pkg-config ca-certificates curl wget git libssl-dev \
        software-properties-common gcc-multilib python2.7-dev bc \
        python-pip python-virtualenv check linux-headers-generic \
        apt-transport-https && \
        apt-get autoremove -y && \
        apt-get clean && \
        rm -rf /var/lib/apt/lists* /tmp/* /var/tmp/*

# Add the proxy cert (needs to come after ca-certificates installation)
ADD proxy.crt /usr/local/share/ca-certificates/proxy.crt
RUN chmod 644 /usr/local/share/ca-certificates/proxy.crt
RUN update-ca-certificates --fresh

# where we build
RUN mkdir /source
VOLUME ["/source"]
WORKDIR /source
CMD ["/bin/bash"]
