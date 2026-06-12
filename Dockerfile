# syntax=docker/dockerfile:1

FROM ghcr.io/linuxserver/baseimage-selkies:debiantrixie

# set version label
ARG BUILD_DATE
ARG VERSION
ARG STEAMROMMANAGER_VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="thelamer"

# title
ENV TITLE="Steam ROM Manager" \
    PIXELFLUX_WAYLAND=true

RUN \
  echo "**** add icon ****" && \
  curl -o \
    /usr/share/selkies/www/icon.png \
    https://raw.githubusercontent.com/SteamGridDB/steam-rom-manager/master/src/assets/icons/512x512.png && \
  echo "**** install runtime packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    libasound2t64 \
    libatk-bridge2.0-0t64 \
    libatk1.0-0t64 \
    libcairo2 \
    libcups2t64 \
    libdbus-1-3 \
    libdrm2 \
    libexpat1 \
    libgbm1 \
    libglib2.0-0t64 \
    libgtk-3-0t64 \
    libnspr4 \
    libnss3 \
    libpango-1.0-0 \
    libsecret-1-0 \
    libx11-6 \
    libx11-xcb1 \
    libxcb1 \
    libxcomposite1 \
    libxdamage1 \
    libxext6 \
    libxfixes3 \
    libxkbcommon0 \
    libxkbfile1 \
    libxrandr2 \
    libxshmfence1 \
    xdg-utils && \
  echo "**** install steam-rom-manager ****" && \
  if [ -z ${STEAMROMMANAGER_VERSION+x} ]; then \
    STEAMROMMANAGER_VERSION=$(curl -sX GET "https://api.github.com/repos/SteamGridDB/steam-rom-manager/releases/latest" \
      | awk '/tag_name/{print $4;exit}' FS='[""]' | sed 's|^v||'); \
  fi && \
  STEAMROMMANAGER_VERSION="${STEAMROMMANAGER_VERSION#v}" && \
  curl -o \
    /tmp/srm.deb -L \
    "https://github.com/SteamGridDB/steam-rom-manager/releases/download/v${STEAMROMMANAGER_VERSION}/steam-rom-manager_${STEAMROMMANAGER_VERSION}_amd64.deb" && \
  apt-get install -y --no-install-recommends \
    /tmp/srm.deb && \
  echo "**** cleanup ****" && \
  printf "Linuxserver.io version: ${VERSION}\nBuild-date: ${BUILD_DATE}" > /build_version && \
  apt-get autoclean && \
  rm -rf \
    /config/.cache \
    /config/.launchpadlib \
    /tmp/srm.deb \
    /var/lib/apt/lists/* \
    /var/tmp/* \
    /tmp/*

# add local files
COPY /root /

# ports and volumes
EXPOSE 3001

VOLUME /config
