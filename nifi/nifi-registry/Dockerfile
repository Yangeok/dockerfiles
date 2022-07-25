# build phase
FROM alpine:3.9 as build
LABEL stage=build

RUN apk --update add --no-cache \
  &&   apk add --no-cache ca-certificates openssl curl wget \
  &&   update-ca-certificates \
  &&   rm -rf /var/lib/apt/lists/* \
  &&   rm -f /var/cache/apk/*

ARG NIFI_VERSION
ENV NIFI_VERSION $NIFI_VERSION
ARG MIRROR
ENV MIRROR $MIRROR

ENV PROJECT_BASE_DIR /opt/nifi-registry
ENV PROJECT_HOME ${PROJECT_BASE_DIR}/nifi-registry-current

ENV UPSTREAM_BINARY_URL nifi/${NIFI_VERSION}/nifi-registry-${NIFI_VERSION}-bin.tar.gz
ENV DOCKERIZE_VERSION v0.6.1

# Download, validate, and expand Apache NiFi-Registry binary.
RUN mkdir -p ${PROJECT_BASE_DIR} \
  && curl -fSL ${MIRROR}/${UPSTREAM_BINARY_URL} -o ${PROJECT_BASE_DIR}/nifi-registry-${NIFI_VERSION}-bin.tar.gz \
  && echo "$(curl ${MIRROR}/${UPSTREAM_BINARY_URL}.sha256) *${PROJECT_BASE_DIR}/nifi-registry-${NIFI_VERSION}-bin.tar.gz" | sha256sum -c - \
  && tar -xvzf ${PROJECT_BASE_DIR}/nifi-registry-${NIFI_VERSION}-bin.tar.gz -C ${PROJECT_BASE_DIR} \
  && rm ${PROJECT_BASE_DIR}/nifi-registry-${NIFI_VERSION}-bin.tar.gz \
  && rm -fr ${PROJECT_HOME}/docs

RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
  && tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
  && rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz

# base phase
FROM openjdk:8-jdk-alpine as base

RUN apk --update add --no-cache ca-certificates bash git less openssh sshpass \
  && update-ca-certificates \
  &&   rm -rf /var/lib/apt/lists/* \
  &&   rm -f /var/cache/apk/*

ARG NIFI_VERSION
ENV NIFI_VERSION $NIFI_VERSION

ENV PROJECT_BASE_DIR /opt/nifi-registry
ENV PROJECT_HOME ${PROJECT_BASE_DIR}/nifi-registry-${NIFI_VERSION}

ENV PROJECT_TEMPLATE_DIR ${PROJECT_BASE_DIR}/templates

ENV PROJECT_CONF_DIR ${PROJECT_HOME}/conf

# Setup NiFi-Registry user
RUN mkdir -p ${PROJECT_BASE_DIR}

COPY --from=build ${PROJECT_HOME} ${PROJECT_HOME}
COPY --from=build /usr/local/bin/dockerize /usr/local/bin/dockerize
COPY ./templates ${PROJECT_TEMPLATE_DIR}

COPY ./scripts ${PROJECT_BASE_DIR}/scripts/

RUN mkdir -p ${PROJECT_HOME}/docs

# Web HTTP(s) ports
EXPOSE 18080 18443

WORKDIR ${PROJECT_HOME}

FROM base as plain

# Apply configuration and start NiFi Registry
CMD ${PROJECT_BASE_DIR}/scripts/start-plain.sh

FROM plain as plainuser
ARG UID=1000
ARG GID=1000

RUN addgroup -g ${GID} nifi \
  && adduser -s /bin/bash -u ${UID} -G nifi -D nifi \
  && chown -R nifi:nifi ${PROJECT_BASE_DIR}
USER nifi

FROM base as default

ENV FLOW_PROVIDER file
ENV FLOW_PROVIDER_GIT_FLOW_STORAGE_DIRECTORY $PROJECT_BASE_DIR/flow-storage
ENV FLOW_PROVIDER_FILE_FLOW_STORAGE_DIRECTORY $PROJECT_BASE_DIR/flow-storage

ENV EXTENSION_BUNDLE_PROVIDER file
ENV EXTENSION_BUNDLE_PROVIDER_FILE_EXTENSION_BUNDLE_STORAGE_DIRECTORY $PROJECT_BASE_DIR/extension-bundle-storage

# Apply configuration and start NiFi Registry
CMD ${PROJECT_BASE_DIR}/scripts/start.sh

FROM default as defaultuser
ARG UID=1000
ARG GID=1000

RUN addgroup -g ${GID} nifi \
  && adduser -s /bin/bash -u ${UID} -G nifi -D nifi \
  && chown -R nifi:nifi ${PROJECT_BASE_DIR}
USER nifi
