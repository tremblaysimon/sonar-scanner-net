FROM openjdk:8u171-jre-stretch

LABEL maintainer="Emerald Squad"
LABEL github="https://github.com/emerald-squad/sonar-scanner-net"

ENV SONAR_SCANNER_MSBUILD_VERSION=4.3.1.1372 \
    SONAR_SCANNER_VERSION=3.2.0.1227 \
    DOTNET_SDK_VERSION=2.2 \
    SONAR_SCANNER_MSBUILD_HOME=/opt/sonar-scanner-msbuild \
    DOTNET_PROJECT_DIR=/project \
    DOTNET_SKIP_FIRST_TIME_EXPERIENCE=true \
    DOTNET_CLI_TELEMETRY_OPTOUT=true

RUN set -x \
  && apt-get update \
  && apt-get install \
    libunwind8 \
    gettext \
    apt-transport-https \
    wget \
    unzip \
    -y \
  && wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.asc.gpg \
  && mv microsoft.asc.gpg /etc/apt/trusted.gpg.d/ \
  && sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/debian/9/prod stretch main" > /etc/apt/sources.list.d/microsoft-prod.list' \
  && apt-get update \
  && apt-get install dotnet-sdk-$DOTNET_SDK_VERSION -y \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN dotnet tool install dotnet-sonarscanner --tool-path $SONAR_SCANNER_MSBUILD_HOME

RUN mkdir -p $DOTNET_PROJECT_DIR

ENV PATH="$SONAR_SCANNER_MSBUILD_HOME:${PATH}"
