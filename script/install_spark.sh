#!/bin/bash
# Variable
export sparkVersion=3.4.1
export SPARK_HOME=/usr/local/spark

# Download and Extract
wget https://dlcdn.apache.org/spark/spark-$sparkVersion/spark-$sparkVersion-bin-hadoop3.tgz -P /tmp
tar xvzf /tmp/spark-$sparkVersion-bin-hadoop3.tgz 

mv spark-$sparkVersion-bin-hadoop3 $SPARK_HOME
echo "export SPARK_WORKER_INSTANCES=1" > $SPARK_HOME/conf/spark-env.sh


# 환경변수 설정
x=$(cat /etc/bashrc|grep SPARK_HOME)
[[ ${#x} -eq 0 ]]&&echo "
export SPARK_HOME=$SPARK_HOME
export PYSPARK_PYTHON=python3
export PATH=\$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin
">>/etc/bashrc && . /etc/bashrc

# Start service
start-master.sh

# check 
jps|grep Master
pyspark --version
curl http://127.0.0.1:8080/|head -n 3

#cf ) History Server
#start-history-server.sh
#curl http://127.0.0.1:18080/
