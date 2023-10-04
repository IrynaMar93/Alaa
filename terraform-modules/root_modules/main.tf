terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.19.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "networking" {
    source = "../modules/networking_components_module"
    vpc_cidr_block = "10.0.0.0/16"
    subnet_cidr_block = "10.0.0.0/24"
}

module "security_group" {
    source = "../modules/security_group_module"
    vpc_id = module.networking.vpc.id
}

module "key_name" {
    source = "../modules/ssh_key_module"
}

module "instance" {
    source          = "../modules/ec2_module"
    ami             = "ami-0bb4c991fa89d4b9b"
    instance_type   = "t3.micro"
    key_name        = module.key_name
    vpc_security_group_ids = [module.security_group.allow_http.id]
    subnet_id = module.networking.subnet_id
}

output "vpc_id" {
value = module.networking.vpc_id.id
}

output "subnet_id" {
value = module.networking.subnet_id.id
}

output "security_group" {
value = module.security_group.allow_http.id
}

output "public_ip" {
value = module.instance.instance_public_ip
}

output "key_name" {
value = module.key_name.key_name
}