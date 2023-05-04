resource "aws_iam_role_policy" "ec2_policy" {
  name = "ec2_policy6"
  role = aws_iam_role.ec2_role.id

  policy = "${file("../module/iam/ec2-policy.json")}"
  
}

resource "aws_iam_role" "ec2_role" {
  name = "ec2_role6"

  assume_role_policy = "${file("../module/iam/ec2-assume.json")}"
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_profile6"
  role = aws_iam_role.ec2_role.name
}