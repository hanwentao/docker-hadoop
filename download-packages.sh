#!/bin/bash

set -e

cd $(dirname $0)
source ./env
mkdir -p packages
curl -o packages/hadoop-$HADOOP_VERSION.tar.gz \
    https://archive.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz
