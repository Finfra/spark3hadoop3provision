#!/bin/bash

yum update -y
sudo yum install -y java-1.8.0-openjdk java-1.8.0-openjdk-devel
java -version

javaPath=$(ls -als $(ls -als $(which java) |awk '{print $NF}')|awk '{print $NF}')
javaFolder=$(echo $javaPath|xargs dirname)
jreHome=$(echo $javaFolder|xargs dirname)
javaHome=$(echo $jreHome|xargs dirname)


x=$(cat /etc/bashrc|grep JAVA_HOME)
[[ ${#x} -eq 0 ]]&&echo "
export JAVA_HOME=$javaHome
export JRE_HOME=$jreHome
export PATH=$PATH:$HOME/bin:$javaFolder
" >> /etc/bashrc && . /etc/bashrc
