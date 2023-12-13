#! /usr/bin/env bash

OUT_DIR="streaming_wc_result"

NUM_REDUCERS=8

hdfs dfs -rm -r -skipTrash $OUT_DIR*  1>/dev/null

yarn jar /opt/cloudera/parcels/CDH/lib/hadoop-mapreduce/hadoop-streaming.jar \
    -D mapreduce.job.reduces=${NUM_REDUCERS} \
    -files mapper.py,reducer.py \
    -mapper mapper.py \
    -reducer reducer.py \
    -input /data/ids \
    -output $OUT_DIR 1>/dev/null


hdfs dfs -cat ${OUT_DIR}/part-00000 | head -n 50
