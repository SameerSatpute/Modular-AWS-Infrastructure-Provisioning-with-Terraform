resource "aws_security_group" "security_group" {
  name = "security_group"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id = var.vpc_id


  tags = {
    Name = "security_group"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ingress-rule" {
  security_group_id = aws_security_group.security_group.id
  cidr_ipv4 = var.cidripv4
  ip_protocol = var.protocol
  from_port = var.ssh
  to_port = var.ssh1
  description = "In this user will be able to create security group"
}

resource "aws_vpc_security_group_egress_rule" "egress" {
  security_group_id = aws_security_group.security_group.id
  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol = "-1"
}


