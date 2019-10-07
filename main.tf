# Null provider example

variable "num_instances" {
    default = 3
}

# AWS provider
provider "aws" {
  profile    = "default"
  region     = "eu-central-1"
}

resource "aws_instance" "futureweb" {
  count = var.num_instances
  ami           = "ami-048d25c1bda4feda7" # Ubuntu 18.04.3 Bionic, custom
  instance_type = "t2.micro"
  tags = {
    "name" = "futureweb-${count.index}"
  }
}

resource "null_resource" "collect_ips_in_file" {
  count = var.num_instances 
  
  provisioner "local-exec" {
    command = "echo ${element(aws_instance.futureweb.*.public_ip, count.index)} >> public_ips.txt"
  }
}

