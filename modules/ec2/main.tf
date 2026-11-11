resource "aws_key_pair" "key_pair" {
  key_name   = var.key_name
  public_key = file(var.public_key)
  tags = {
    Name = "key_pair"
  }
}

resource "aws_instance" "new_infra" {
  for_each = var.ec2

  ami = each.value.ami
  instance_type = each.value.instance_type
  key_name = aws_key_pair.key_pair.key_name
  subnet_id = each.value.subnet_id
  associate_public_ip_address = each.value.public_ip
  vpc_security_group_ids = each.value.security_group_ids
  iam_instance_profile = each.value.instance_profile

  root_block_device {
    volume_size = each.value.volume_size
    volume_type = each.value.volume_type
  }

  tags = {
    Name = each.key
  }
}


