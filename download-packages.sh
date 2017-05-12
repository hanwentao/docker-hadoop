#!/bin/bash

set -e

HADOOP_VERSION=2.8.0

cd $(dirname $0)
mkdir -p packages
curl -o packages/hadoop-$HADOOP_VERSION.tar.gz \
    https://archive.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz
