# spark3hadoop3provision
install single node install spark3 and hadoop3


# Install 
```
export hostname=spark0
sudo hostname $hostname
x=$(cat /etc/hostname|grep $hostname)
[[ ${#x}  -eq 0 ]]&& sudo bash -c "echo $hostname > /etc/hostname"

sudo yum update -y
sudo yum instal -y git

git clone https://github.com/Finfra/spark3hadoop3provision
cd spark3hadoop3provision/script
. install.sh

```

# AMI 
* ID : ami-045b4f0a573d645d1
* Name : finfra_spark3hadoop3
* Script for first login
```
sudo -i
rm -rf ~/.ssh/known_hosts
```