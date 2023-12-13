#! /usr/bin/env bash

BLOCK_ID=`hdfs fsck $1 -files -blocks -locations | egrep -o 'blk_[0-9]*'`
hdfs fsck -blockId $BLOCK_ID | grep -oP '(?<=rack: ).*(?=/default)' | head -1
