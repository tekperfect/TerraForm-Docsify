resource "aws_vpc" "vpc-1" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "tf-vpc"
    }
  
}


resource "aws_vpc" "vpc-2" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "tf-vpc"
    }
  
}


resource "aws_subnet" "subnet-1" {
    vpc_id      = aws_vpc.vpc-1.id
    cidr_block  = "10.0.1.0/24"
}

resource "aws_subnet" "subnet-2" {
    vpc_id      = aws_vpc.vpc-2.id
    cidr_block  = "10.0.1.0/24"
}

