# Flutter (https://flutter.io) Developement Environment for Linux
# ===============================================================
#
# This environment passes all Linux Flutter Doctor checks and is sufficient
# for building Android applications and running Flutter tests.
#
# To build iOS applications, a Mac development environment is necessary.
#

FROM gcr.io/cloud-builders/gcloud
MAINTAINER Chinmay Garde <chinmaygarde@google.com>

# Install Dependencies.
RUN apt-get update -y
RUN apt-get install -y \
  git \
  curl \
  unzip \
  libc6

# Install Flutter.
ENV FLUTTER_ROOT="/opt/flutter"
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
