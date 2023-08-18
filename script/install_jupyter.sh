#!/bin/bash
x=$(cat /etc/*lease|grep ^ID=)
if [ $x = 'ID="centos"' ];then
echo "---------Centos---------"
elif [ $x = 'ID="amzn"' ];then
echo "---------Amazon Linux---------"
yum remove -y python3-requests-2.25.1
else
    echo "No supported os : this os id is $x"
    exit
fi 


yum install -y python3-pip
pip3 install jupyter 

x=$(cat /etc/bashrc|grep PYSPARK_DRIVER_PYTHON)
[[ ${#x} -eq 0 ]]&&echo "
export PYSPARK_DRIVER_PYTHON=jupyter
export PYSPARK_DRIVER_PYTHON_OPTS='notebook --ip=0.0.0.0 --port=7777 --allow-root'
">>/etc/bashrc && . /etc/bashrc

# iptables -A DOCKER -p tcp --dport 7777 -j ACCEPT -d 0.0.0.0
# iptables -t nat -A DOCKER -p tcp --dport 7777 -j DNAT --to 0.0.0.0:7777
# iptables -t nat -A POSTROUTING -p tcp --dport 7777 -j MASQUERADE -s 0.0.0.0 -d 0.0.0.0

pyspark --master yarn

