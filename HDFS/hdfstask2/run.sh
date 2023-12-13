#!/usr/bin/env bash

HOST=$(curl -i "http://mipt-master.atp-fivt.org:50070/webhdfs/v1$1?op=OPEN" | grep -oP '(?<=Location: ).*(?=.)')
HOST="${HOST}&length=10"
curl -i "$HOST" | tail -n +8
