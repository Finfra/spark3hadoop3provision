# spark3hadoop3provision
install single node install spark3 and hadoop3


# Install 
```
sudo hostname spark0

sudo yum update -y
sudo yum instal -y git
x=$(cat ~/.bashrc|grep sudo)
[[ ${#x} -eq 0 ]]&& echo "sudo -i" >> ~/.bashrc && . ~/.bashrc
git clone https://github.com/Finfra/spark3hadoop3provision
cd spark3hadoop3provision/script
. install.sh

```