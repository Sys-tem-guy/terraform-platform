# 1. Virtual Private Cloud (VPC)
resource "aws_vpc" "devops_vpc" {
    cidr_block  = var.vpc_cidr
    enable_dns_hostnames = true

    tags = {
        Name = "devops_vpc"
    }
}

# 2. Public Subnet
resource "aws_subnet" "public_subnet" {
    vpc_id            = aws_vpc.devops_vpc.id
    cidr_block        = var.subnet_cidr
    availability_zone = "us-east-1a"

    tags = {
        Name = "public-subnet-1"
    }
}

# 3. Internet Gateway
resource "aws_internet_gateway" "devops_igw" {
    vpc_id = aws_vpc.devops_vpc.id

    tags = {
        Name = "devops-igw"
    }
}

# 4. Route table and Default Internet Route
resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.devops_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.devops_igw.id
    }

    tags = {
        Name = "public-route-table"
    }
}

# 5. Route Table Association
resource "aws_route_table_association" "public_assoc" {
    subnet_id = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.public_rt.id
}

# 6. Security group (firewall)
resource "aws_security_group" "devops_sg" {
    name = "devops-web-sg"
    description = "Allow inbound HTTP and SSH traffic"
    vpc_id = aws_vpc.devops_vpc.id

    ingress {
        description = "SSH"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks =["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "devops-web-sg"
    }
}

# 7. Virtual Machines (EC2 Instance)
resource "aws_instance" "devops_server" {
    ami = "ami-12345678"
    instance_type = var.instance_type
    subnet_id = aws_subnet.public_subnet.id
    vpc_security_group_ids = [aws_security_group.devops_sg.id]

    tags = {
        Name = "devops-server"
    }
}