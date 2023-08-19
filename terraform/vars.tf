variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
  default = "ap-northeast-2"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "~/.ssh_provision/id_rsa"
}
variable "PATH_TO_PUBLIC_KEY" {
  default = "~/.ssh_provision/id_rsa.pub"
}
variable "INSTANCE_USERNAME" {
  default = "ec2-user"
}

variable "AMIS" {
  default = {
    ap-northeast-2 = "ami-0649a417eaba9ac54"
  }
} 


variable "instance_count" {
  default = "14"
}


variable "instance_type" {
  default = "t2.large"
}
