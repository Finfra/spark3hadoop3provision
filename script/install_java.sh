#!/bin/bash

# Java Install 
x=$(cat /etc/*lease|grep ^ID=)
if [ $x = 'ID="centos"' ];then
echo "---------Centos---------"
yum update -y
yum install -y java-1.8.0-openjdk java-1.8.0-openjdk-devel
#java -version


elif [ $x = 'ID="amzn"' ];then
echo "---------Amazon Linux---------"
dnf install -y java-1.8.0-amazon-corretto java-1.8.0-amazon-corretto-devel

else
    echo "No supported os : this os id is $x"
    exit
fi 


# Java Setting
javaPath=$(ls -als $(ls -als $(which java) |awk '{print $NF}')|awk '{print $NF}')
javaFolder=$(echo $javaPath|xargs dirname)
jreHome=$(echo $javaFolder|xargs dirname)
javaHome=$(echo $jreHome|xargs dirname)

x=$(cat /etc/bashrc|grep JAVA_HOME)
[[ ${#x} -eq 0 ]]&&echo "
export JAVA_HOME=$javaHome
export JRE_HOME=$jreHome
export PATH=\$PATH:$HOME/bin:$javaFolder
" >> /etc/bashrc && . /etc/bashrc
