FROM ubuntu:16.04
LABEL maintainer "Wentao Han <wentao.han@gmail.com>"

ENV HADOOP_VERSION 2.8.0
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV HADOOP_HOME /opt/hadoop

RUN apt-get update && apt-get install -y \
    openjdk-8-jdk-headless \
    openssh-server \
    rsync \
    supervisor \
 && rm -rf /var/lib/apt/lists/*

# Set up Hadoop files
WORKDIR /opt
ADD packages/hadoop-$HADOOP_VERSION.tar.gz .
RUN chown -R root:root hadoop-$HADOOP_VERSION \
 && ln -s hadoop-$HADOOP_VERSION hadoop

# Set up ssh without password
WORKDIR /root
ADD ssh/config .ssh/config
RUN ssh-keygen -t rsa -f ~/.ssh/id_rsa -N "" \
 && cat ~/.ssh/id_rsa.pub >>~/.ssh/authorized_keys \
 && echo "AcceptEnv PATH JAVA_HOME HADOOP_HOME" >>/etc/ssh/sshd_config \
 && mkdir -p /var/run/sshd

# Set up Hadoop environment
ADD hadoop/etc/hadoop/* $HADOOP_HOME/etc/hadoop/

# Initialize HDFS
RUN rm -rf /tmp/* \
 && $HADOOP_HOME/bin/hdfs namenode -format

# Add supervisor configuration
ADD supervisor/*.conf /etc/supervisor/conf.d/

EXPOSE 8088 50070
ENTRYPOINT /usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf
