output "vpc_id" {
    description = "The ID of the provisioned custom VPC"
    value = aws_vpc.devops_vpc.id
}

output "subnet_id" {
    description = "The ID of the public subnet"
    value = aws_subnet.public_subnet.id
}

output "security_group_id" {
    description = "The ID of the web security group"
    value = aws_security_group.devops_sg.id
}

output "server_id" {
    description = "The ID of the EC2 instance"
    value = aws_instance.devops_server.id
}

output "server_private_ip" {
    description = "Private IP of the server"
    value = aws_instance.devops_server.private_ip
}