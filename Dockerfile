FROM ubuntu:16.04
LABEL maintainer "Wentao Han <wentao.han@gmail.com>"

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV HADOOP_VERSION 2.8.0
ENV HADOOP_PREFIX /opt/hadoop

RUN apt-get update && apt-get install -y \
    openjdk-8-jdk-headless \
    openssh-server \
    rsync \
 && rm -rf /var/lib/apt/lists/*

# Set up Hadoop files
ADD packages/hadoop-$HADOOP_VERSION.tar.gz /opt
RUN chown -R root:root /opt/hadoop-$HADOOP_VERSION \
 && ln -s hadoop-$HADOOP_VERSION /opt/hadoop

# Set up ssh without password
RUN ssh-keygen -t rsa -f /root/.ssh/id_rsa -N "" \
 && cat /root/.ssh/id_rsa.pub >>/root/.ssh/authorized_keys \
 && echo "HashKnownHosts no" >>/root/.ssh/config \
 && echo "StrictHostKeyChecking no" >>/root/.ssh/config \
 && mkdir -p /var/run/sshd

# Set up Hadoop environment
ADD conf/hadoop/* $HADOOP_PREFIX/etc/hadoop/

WORKDIR $HADOOP_PREFIX
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/sbin/sshd", "-D"]
