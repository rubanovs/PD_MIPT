#! /usr/bin/env bash

hive -f user_logs.hql
hive -f user_data.hql
hive -f ip_data.hql
hive -f subnets.hql
