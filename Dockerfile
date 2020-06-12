# mssql-agent-fts-ha-tools
# Maintainer: Threecomp.ma
# Author: ALOUANE Nour-Eddine 

# Base OS layer: Latest mssql server
FROM mcr.microsoft.com/mssql/server

LABEL maintainer="n.alouane@threecomp.ma"

ENV ACCEPT_EULA=Y

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Install prerequistes since it is needed to get repo config for SQL server
USER root
RUN apt-get update && \
apt-get install -y \
curl apt-transport-https debconf-utils && \
apt-get install -y gnupg2 && \
# Get official Microsoft repository configuration
    curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl https://packages.microsoft.com/config/ubuntu/16.04/mssql-server-2017.list | tee /etc/apt/sources.list.d/mssql-server.list && \
    curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list | tee /etc/apt/sources.list.d/msprod.list && \
apt-get update && \
apt-get install -y tzdata && \
apt-get install -y mssql-server-fts && \
apt-get install -y mssql-server-ha && \

# Cleanup the Dockerfile
apt-get clean && \
rm -rf /var/lib/apt/lists/*

## Set timezone
#
ENV TZ=Africa/Casablanca
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
