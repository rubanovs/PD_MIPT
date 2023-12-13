#!/usr/bin/env bash

HOST=$(hdfs fsck -blockId "$1" | grep -oP '(?<=rack: ).*(?=/def)' | head -1)
PATH=$(sudo -u hdfsuser ssh "$HOST" -tt "find /dfs/ -name \"$1\"")
echo "${HOST}:${PATH}"
