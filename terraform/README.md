# Apply
```
terraform init 
tterraform apply -auto-approve


```

# Test
```
cat terraform.tfstate|jq '.resources[]|select(.type=="aws_eip").instances[].attributes| "\(.public_ip) \(.tags.Name)"' |sed 's/"//g' > hosts
cat hosts

while read i; do
  ip=$(echo $i|awk '{print $1}')
  hostName=$(echo $i|awk '{print $2}'|sed 's/_eip_//g')
  echo $ip - $hostName
  echo $hostName 
  ssh -i ~/.ssh_provision/id_rsa ec2-user@$ip sudo bash -c "echo $hostname > /etc/hostname"
done <hosts

```

# Destroy
```
terraform destroy -auto-approve

```