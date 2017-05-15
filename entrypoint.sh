#!/bin/bash

while read -d, role; do
    case "$role" in
        namenode)
            $HADOOP_PREFIX/sbin/start-dfs.sh
            ;;
        resourcemanager)
            $HADOOP_PREFIX/sbin/start-yarn.sh
            ;;
    esac
done <<<"$HADOOP_ROLES,"

exec "$@"
