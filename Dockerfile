FROM ubuntu:18.04

MAINTAINER stesen "stesen1988@outlook.com"
RUN sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list
RUN apt-get clean
RUN apt-get update

RUN apt-get install -y --no-install-recommends --fix-missing bc bison \
bsdmainutils build-essential ccache curl flex gcc-multilib git-core \
g++-multilib gnupg gperf imagemagick less lib32ncurses5-dev lib32z-dev \
libc6-dev-i386 libgl1-mesa-dev libx11-dev libxml2-utils lunzip \
openjdk-8-jdk python3 python-networkx rsync schedtool unzip x11proto-core-dev \
xsltproc zip zlib1g-dev gnutls-bin git

ADD https://storage.googleapis.com/git-repo-downloads/repo /usr/local/bin/repo
RUN chmod 0755 /usr/local/bin/repo

ARG ANDROID_GID=1000
ARG ANDROID_UID=1000
ARG ANDROID_NAME="android"
ARG ANDROID_EMAIL="android@localhost.localdomain"
# Create the "android" user and group
RUN groupadd --gid $ANDROID_GID android && useradd --gid android \
--uid $ANDROID_UID --comment "android repo sync" --create-home android
USER android
# Configure git
RUN git config --global color.ui auto && \
git config --global user.name "$ANDROID_NAME" && \
git config --global user.email "$ANDROID_EMAIL"

# Mount point for the Android source tree
VOLUME /android
# This container should be run interactively
WORKDIR /android

ENTRYPOINT ["/bin/bash"]
#RUN python3 /usr/local/bin/repo sync -c --no-tags
