variable "aws_region" {
    description = "Target AWS deployment region"
    type = string
    default = "us-east-1"
}

variable "vpc_cidr" {
    description = "Base CIDR block for the custom VPC"
    type = string
    default = "10.0.0.0/16"
}

variable "subnet_cidr" {
    description = "CIDR block for the public subnet"
    type = string
    default = "10.0.1.0/24"
}

variable "availability_zone" {
    description = "Target availability zone for the subnet"
    type = string
    default = "us-east-1a"
}

variable "instance_type" {
    description = "EC2 compute size"
    type = string
    default = "t2.micro"
}