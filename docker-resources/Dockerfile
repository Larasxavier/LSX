ARG MAJOR_VERSION=6.0
ARG ZBX_VERSION=${MAJOR_VERSION}.23
ARG BUILD_BASE_IMAGE=zabbix/zabbix-server-mysql:${ZBX_VERSION}-centos

FROM ${BUILD_BASE_IMAGE} as builder

LABEL maintainer="Lara Silva Xavier <laritxas@gmail.com>"

USER root

COPY odbc.ini /etc/odbc.ini

COPY mysql-connector-odbc-8.2.0-1.el8.x86_64.rpm /tmp

RUN \
    yum install -y unixODBC unixODBC-devel /tmp/mysql-connector-odbc-8.2.0-1.el8.x86_64.rpm