FROM oraclelinux:7-slim

MAINTAINER Artyom Konovalenko <nopius@vl.ru>
RUN yum-config-manager --enable ol7_software_collections
RUN yum install -y http://www.percona.com/downloads/percona-release/redhat/0.1-3/percona-release-0.1-3.noarch.rpm
RUN yum install -y procps-ng util-linux openssl numactl Percona-Server-MongoDB-34 Percona-Server-MongoDB-34-mongos Percona-Server-MongoDB-34-server Percona-Server-MongoDB-34-shell Percona-Server-MongoDB-34-tools&& yum clean all
EXPOSE 27017/tcp
ADD mkshard mkshard
ADD mkdb mkdb
ENTRYPOINT [ "/usr/bin/mongos -f /etc/mongos-proxy.conf" ]
