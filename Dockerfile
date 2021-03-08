# Flutter (https://flutter.io) Developement Environment for Linux
# ===============================================================
#
# This environment passes all Linux Flutter Doctor checks and is sufficient
# for building Android applications and running Flutter tests.
#
# To build iOS applications, a Mac development environment is necessary.
#

FROM debian:stretch
MAINTAINER Chinmay Garde <chinmaygarde@google.com>

# Install Dependencies.
RUN apt-get update -y
RUN apt-get install -y \
  git \
  curl \
  unzip \
  libc6

# Set up new user
RUN useradd -ms /bin/bash developer
USER developer
WORKDIR /home/developer

# Install Flutter.
ENV FLUTTER_ROOT="/home/developer/flutter"
RUN git clone https://github.com/flutter/flutter "${FLUTTER_ROOT}"
ENV PATH="${FLUTTER_ROOT}/bin:${PATH}"

# Disable analytics and crash reporting on the builder.
RUN flutter config  --no-analytics

# Perform an artifact precache so that no extra assets need to be downloaded on demand.
RUN flutter precache --web

# Perform a doctor run.
RUN flutter doctor -v

# Switch to the correct channel
ARG channel=stable
RUN flutter channel $channel

# Perform a flutter upgrade
RUN flutter upgrade

ENTRYPOINT [ "flutter" ]
