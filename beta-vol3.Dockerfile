#
# This Docker image encapsulates the Volatility Framework (version 2.6.1) by The 
# Volatility Foundation from http://www.volatilityfoundation.org/#!releases/component_71401
#
# To run this image after installing Docker, use the following command:
# sudo docker run --rm -it -v ~/memdumps:/home/nonroot/memdumps remnux/volatility bash
#
# Before running Volatility, create the ~/memdumps directory and make it world-accessible
# (“chmod a+xwr").

## from 14.04 -> 18.04 LTS, but 18.04 today has apt errors that fail the build
## 16.04 ships python3.5 which vol3 setup.py dies :"ImportError: cannot import name 'ClassVar'"
FROM ubuntu:18.04
# MAINTAINER Zod (@wzod)
## damaged by @adricnet for @dfirnotes

# Install packages from apt repository
USER root
RUN apt-get -qq update && apt-get install -y \
  automake \
  build-essential \
  git \
  ipython \
  libbz2-dev \
  libc6-dev \
  libfreetype6-dev \
  libgdbm-dev \
  libjansson-dev \
  libjpeg8-dev \
  libmagic-dev \
  libreadline-gplv2-dev \
  libtool \
  python3 \
  python3-defaults \
  python3-dev \
  python3-pip \
  tar \
  unzip \
  wget \
  zlib1g \
  zlib1g-dev && \
  
## Ensure we're using Python 3, ugly
## ln -fs /usr/bin/python3 /usr/bin/python
  
# Install additional dependencies
##RUN pip3 install distorm3 \
##  openpyxl==2.3.0 \
##  pycrypto \
##  pytz

# Retrieve remaining dependencies

#
RUN cd /tmp && \
  wget -O beta.1.tar.gz "https://github.com/volatilityfoundation/volatility3/archive/v1.0.0-beta.1.tar.gz" && \
  tar vxzf beta.1.tar.gz 

# Verify hashes FIXME
 
# Add nonroot user and setup environment
RUN groupadd -r nonroot && \
  useradd -r -g nonroot -d /home/nonroot -s /sbin/nologin -c "Nonroot User" nonroot && \
  mkdir /home/nonroot && \
  mv -vf /tmp/volatility3-1.0.0-beta.1 /home/nonroot && \

# Setup Volatility
  cd /home/nonroot/volatility3-1.0.0-beta.1 && \
  chmod +x vol.py && \
  ln -fs /home/nonroot/volatility3-1.0.0-beta.1/vol.py /usr/local/bin/ && \
  chown -R nonroot:nonroot /home/nonroot

# Clean up
RUN apt-get remove -y --purge automake build-essential libtool && \
  apt-get autoremove -y --purge && \
  apt-get clean -y && \
  rm -rf /var/lib/apt/lists/*

USER nonroot
ENV HOME /home/nonroot
ENV USER nonroot
WORKDIR /home/nonroot/volatility3-1.0.0-beta.1
