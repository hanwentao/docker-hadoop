#!/bin/bash

set -e

/usr/sbin/sshd -D &

if [[ "${IS_HDFS_MASTER}" == "true" ]]; then
  echo "Starting HDFS processes..."
  if [[ ! -d /var/lib/hadoop/dfs/name ]]; then
    ${HADOOP_PREFIX}/bin/hdfs namenode -format
  fi
  ${HADOOP_PREFIX}/sbin/start-dfs.sh
fi

if [[ "${IS_YARN_MASTER}" == "true" ]]; then
  echo "Starting YARN processes..."
  ${HADOOP_PREFIX}/sbin/start-yarn.sh
fi

wait
