resource "aws_iam_instance_profile" "ecsInstanceRole-profile" {
  name = "ecsInstanceRole-profile"
  role = aws_iam_role.role.name
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "role" {
  name               = "ecsInstanceRole_role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "task_ssm" {
  count      = length(var.policies)
  role       = aws_iam_role.role.name
  policy_arn = var.policies[count.index]
}