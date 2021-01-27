FROM ubuntu:19.10
MAINTAINER Doug Goldstein <doug.goldstein@starlab.io>

ENV DEBIAN_FRONTEND=noninteractive
ENV USER root

# build depends. Please keep the package list sorted
RUN apt-get update && \
    apt-get --quiet --yes install \
        apt-transport-https \
        bc \
        build-essential \
        ca-certificates \
        check \
        curl \
        gcc-multilib \
        git \
        libssl-dev \
        linux-headers-generic \
        pkg-config \
        python2.7-dev \
        python-pip \
        python-virtualenv \
        software-properties-common \
        wget \
    &&  apt-get autoremove -y && \
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
