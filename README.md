# mkshard
Bash script that prepares and starts mongo cluster locally on RHEL/CentOS/OracleLinux 7.x machine without using docker or kubernetes. Tested it on OracleLinux 7.5

Requires root privileges. TODO: phase out sudo and root privs.

This script can be useful for those who want to run mongo cluster on local machine without using docker images. Main purpose of this project is to prepare and run mongo cluster from scratch (with one command), mostly for running tests on external applications that depends on mongo cluster. Created mongo cluster starts with authentication enabled and can be preconfigured with custom number of shards, replicas, users and roles. 


!!! DON'T RUN THIS SCRIPT on a server where Mongo is already configured and running !!!

!!! Otherwise this script CAN DESTROY ALL MONGODB DATA on already configured server !!!

Sharded Mongo cluster consists of the following components:

- config servers (3 recommended for production)
- replica-sets (3 or more recommended for production)
- mongos router (1 or more), that routes data to shards according to sharding algorithm
- shards (usually 2 or more), thats themselves are replica-sets, which keep partial data

## USAGE

Usage: sudo ./mkshard create|destroy

  create  - creates and starts MongoDB sharded cluster on localhost
  
  destroy - stops MongoDB cluster AND DESTROYS ALL DATA

- Default databases dir: /opt/mongod/
- Default logs dir: /var/log/mongodb/
- Default DBA login/password: admin:admin
- Default mongos port: 27017

There are some 'sleeps' in the script inserted to complete 'primary' member election inside cluster. While creating mongo cluster it may look like 'script hangs', but it is not. On my PC cluster creation (with downloading and installing mongo packages) takes 3m 38s:
```
/usr/bin/time sudo ./mkshard create
Loaded plugins: langpacks, rhnplugin
This system is receiving updates from RHN Classic or Red Hat Satellite.
oraclelinux7-x86_64-uekr5                                                                                                   oraclelinux7-x86_64-uekr5/updateinfo                                                                                       oraclelinux7-x86_64-uekr5/primary                                                                                           oraclelinux7-x86_64-uekr5                                                                                                   Percona-Server-MongoDB-34-3.4.16-2.14.el7.x86_64.rpm                                                                       Examining /var/tmp/yum-root-slWagO/Percona-Server-MongoDB-34-3.4.16-2.14.el7.x86_64.rpm: Percona-Server-MongoDB-34-3.4.16-2.14.el7.x86_64
...
{ "ok" : 1 }
{ "ok" : 1 }
{ "ok" : 1 }
{ "ok" : 1 }
{ "ok" : 1 }
{ "ok" : 1 }
{ "ok" : 1 }
{ "ok" : 1 }
{ "ok" : 1 }
{ "ok" : 1 }
{ "ok" : 1 }
{ "ok" : 1 }
Percona Server for MongoDB shell version v3.4.16-2.14
connecting to: mongodb://127.0.0.1:27017
...
Successfully added user: { "user" : "zabbix_mon", "roles" : [ "monitoringRole" ] }
6.82user 1.82system 3:38.10elapsed 3%CPU (0avgtext+0avgdata 38220maxresident)k
3784inputs+201880outputs (32major+491233minor)pagefaults 0swaps
```

## TESTING
```
mongo --norc -u admin -p admin --authenticationDatabase admin
Percona Server for MongoDB shell version v3.4.16-2.14
connecting to: mongodb://127.0.0.1:27017
Percona Server for MongoDB server version: v3.4.16-2.14
mongos> sh.status()
--- Sharding Status --- 
  sharding version: {
  	"_id" : 1,
  	"minCompatibleVersion" : 5,
  	"currentVersion" : 6,
  	"clusterId" : ObjectId("5bf61ae2851db061b00a5a84")
  }
  shards:
        {  "_id" : "shard0",  "host" : "shard0/localhost:27023,localhost:27024,localhost:27025",  "state" : 1 }
        {  "_id" : "shard1",  "host" : "shard1/localhost:27026,localhost:27027,localhost:27028",  "state" : 1 }
        {  "_id" : "shard2",  "host" : "shard2/localhost:27029,localhost:27030,localhost:27031",  "state" : 1 }
  active mongoses:
        "3.4.16-2.14" : 1
  autosplit:
        Currently enabled: yes
  balancer:
        Currently enabled:  yes
        Currently running:  no
NaN
        Failed balancer rounds in last 5 attempts:  1
        Last reported error:  Connection refused
        Time of Reported error:  Thu Nov 22 2018 12:59:17 GMT+1000
        Migration Results for the last 24 hours: 
                No recent migrations
  databases:
```
