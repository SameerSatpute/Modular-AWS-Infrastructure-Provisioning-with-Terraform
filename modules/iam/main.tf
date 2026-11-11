data "aws_iam_policy_document" "ec2_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = var.policy
      identifiers = var.identifier
    }
  }
}

resource "aws_iam_role" "role" {
  name = var.rolename
  description = "Allows EC2 instances to access S3" 
  assume_role_policy = data.aws_iam_policy_document.ec2_policy.json

  tags = {
    tag-key = "policy to make role"
  }
}

resource "aws_iam_role_policy_attachment" "attach_policy" {
  role       = aws_iam_role.role.name
  policy_arn = var.arn
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = var.instance_profile
  role = aws_iam_role.role.name 
}

