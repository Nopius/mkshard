#!/bin/bash
/mkshard 
#/mkdb default removedInfos
# stop mongos proxy and run in forground (container live until process is running)
/etc/init.d/mongos-proxy stop
sed -i -e '/fork/s/true/false/' /etc/mongos-proxy.conf
/usr/bin/mongos -f /etc/mongos-proxy.conf

