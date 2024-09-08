

provider "aws" {
  region     = "us-east-1"
  access_key = "give your access key*********"
  secret_key = "give your secret key*********"
}

  module "aws_vpc" {
    source                    = "./vpc/ec2_instance"
    ami_id                    = "give your ami id********"
    instance_type             = "t2.micro"
    cidr_block                = "10.0.0.0/16"
    subnet-public-cidr_block  = "10.0.1.0/24"
    subnet-private-cidr_block = "10.0.3.0/24"

  }




