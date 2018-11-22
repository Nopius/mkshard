# mkshard
Bash script that prepares and starts mongo cluster locally on RHEL/CentOS/OracleLinux 7.x machine without using docker or kubernetes. Tested it on OracleLinux 7.5

This script can be useful for those who want to run mongo cluster on local machine without using docker images. Main purpose of this project is to prepare and run mongo cluster from scratch (with one command), mostly for running tests on external applications that depends on mongo cluster. Created mongo cluster starts with authentication enabled and can be preconfigured with custom number of shards, replicas, users and roles. 

!!! DON'T RUN THIS SCRIPT on a server where Mongo is already configured and running !!!
!!! Otherwise this script CAN DESTROY ALL MONGODB DATA on already configured server !!!

Sharded Mongo cluster consists of the following components:
- config servers (3 recommended for production)
- replica-sets (3 or more recommended for production)
- mongos router (1 or more), that routes data to shards according to sharding algorithm
- shards (usually 2 or more), thats themselves are replica-sets, which keep partial data

Usage: sudo ./mkshard {create|destroy}
  create  - creates and starts MongoDB sharded cluster on localhost
  destroy - stops MongoDB cluster AND DESTROYS ALL DATA
  

  
