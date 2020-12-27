variable "secret_key" {
    description = "aws secret key"
}

variable "access_key" {
    description = "aws secret key"
}


provider "aws" {
    access_key  = var.access_key
    secret_key  = var.secret_key
    region      = "us-west-1"
}

resource "aws_instance" "linux-web-server" {
    ami             = "t2.micro"
    instance_type   = "ami-00831fc7c1e3ddc60"
    tags = {
        Name = "TF-Linux-Server"
    }
}

resource "aws_vpc" "vpc-1" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "tf-vpc"
    }
  
}

resource "aws_subnet" "subnet-1" {
    vpc_id  = aws_vpc.vpc-1.id
    cidr_block  = "10.0.1.0/24"
  
}
