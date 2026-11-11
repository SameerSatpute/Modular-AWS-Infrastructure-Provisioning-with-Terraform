output "vpc_id" {
  value = aws_vpc.new-infra.id
}

output "subnet_name" {
  value = aws_subnet.subnet1
}

output "subnet_name2" {
  value = aws_subnet.subnet2
}