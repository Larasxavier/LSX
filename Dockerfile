ARG MAJOR_VERSION=6.0
ARG ZBX_VERSION=${MAJOR_VERSION}.23
ARG BUILD_BASE_IMAGE=zabbix/zabbix-server-mysql:${ZBX_VERSION}-centos

FROM ${BUILD_BASE_IMAGE} as builder

LABEL maintainer="Lara Silva Xavier <laritxas@gmail.com>"

USER root

RUN yum clean all && \
    yum repolist && \
    rm -rf /var/cache/yum/*


COPY odbc.ini /etc/odbc.ini

RUN \
    yum install -y unixODBC unixODBC-devel
