#!/bin/bash

# Variable
export hadoopVersion=3.3.6
export HADOOP_HOME=/usr/local/hadoop

# Java install
bash install_java.sh

# Ssh and Key Setting
x=$(cat /etc/ssh/sshd_config|grep "^PermitRootLogin yes")
[[ ${#x} -eq 0 ]]&& echo "PermitRootLogin yes" >> /etc/ssh/sshd_config && systemctl restart sshd.service

ssh-keygen -f ~/.ssh/id_rsa -N ''
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

# Download and Extract
wget https://dlcdn.apache.org/hadoop/common/hadoop-$hadoopVersion/hadoop-$hadoopVersion.tar.gz -P /tmp
tar xvzf /tmp/hadoop-$hadoopVersion.tar.gz

mv hadoop-$hadoopVersion $HADOOP_HOME

# 환경변수 설정
x=$(cat /etc/bashrc|grep HADOOP_HOME)
[[ ${#x} -eq 0 ]]&&echo "
export HADOOP_HOME=$
#Hadoop Environment Variables
export HADOOP_HOME=$HADOOP_HOME
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
export HADOOP_LOG_DIR=$HADOOP_HOME/logs
export HDFS_NAMENODE_USER=root
export HDFS_DATANODE_USER=root
export HDFS_SECONDARYNAMENODE_USER=root
export YARN_RESOURCEMANAGER_USER=root
export YARN_NODEMANAGER_USER=root
# Add Hadoop bin/ directory to PATH
export PATH=\$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
export HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib/native"
">>/etc/bashrc && . /etc/bashrc


x=$(cat $HADOOP_HOME/etc/hadoop/hadoop-env.sh |grep "^export HADOOP_HOME")
if [ ${#x} -eq 0 ]; then
echo "
#JAVA
export JAVA_HOME=$JAVA_HOME
export JRE_HOME=$JRE_HOME
#Hadoop Environment Variables
export HADOOP_HOME=$HADOOP_HOME
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
export HADOOP_LOG_DIR=$HADOOP_HOME/logs
export HDFS_NAMENODE_USER=root
export HDFS_DATANODE_USER=root
export HDFS_SECONDARYNAMENODE_USER=root
export YARN_RESOURCEMANAGER_USER=root
export YARN_NODEMANAGER_USER=root
export YARN_NODEMANAGER_USER=root
# Add Hadoop bin/ directory to PATH
export PATH=\$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
export HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib/native"
">$HADOOP_HOME/etc/hadoop/hadoop-env.sh 

mkdir -p $HADOOP_HOME/hadoop_store/tmp
chmod -R 755 $HADOOP_HOME/hadoop_store/tmp
mkdir -p $HADOOP_HOME/hadoop_store/namenode
mkdir -p $HADOOP_HOME/hadoop_store/datanode
chmod -R 755 $HADOOP_HOME/hadoop_store/namenode
chmod -R 755 $HADOOP_HOME/hadoop_store/datanode



echo '<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
<property>
    <name>hadoop.tmp.dir</name>
    <value>$HADOOP_HOME/hadoop_store/tmp</value>     
</property>    
<property>      
    <name>fs.defaultFS</name>
    <value>hdfs://localhost:9000</value>    
</property>
</configuration>
' >$HADOOP_HOME/etc/hadoop/core-site.xml
echo '<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
<property>
<name>yarn.nodemanager.aux-services</name><value>mapreduce_shuffle</value>
</property>
</configuration>
'>$HADOOP_HOME/etc/hadoop/yarn-site.xml

echo '<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
<property>
<name>dfs.replication</name>
<value>1</value>
</property>
<property>
<name>dfs.name.dir</name><value>/usr/local/hdfs_store/namenode</value>
</property>
<property>
<name>dfs.data.dir</name><value>/usr/local/hdfs_store/datanode</value>
</property>
</configuration>'>$HADOOP_HOME/etc/hadoop/hdfs-site.xml

echo '<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
<property>
<name>mapreduce.framework.name</name>
<value>yarn</value>
</property>
</configuration>'>$HADOOP_HOME/etc/hadoop/mapred-site.xml

echo 'localhost'>$HADOOP_HOME/etc/hadoop/workers

hadoop namenode -format
start-dfs.sh
#start-yarn.sh
# mapred --daemon start historyserver
jps
fi
