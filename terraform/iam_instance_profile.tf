// Assumed Role

resource "aws_iam_instance_profile" "workstation" {
  name = "workstation-route53"
  role = "${aws_iam_role.workstation.name}"
}

resource "aws_iam_role" "workstation" {
  name = "workstation-route53"
  path = "/"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "ec2.amazonaws.com"
        ]
     },
      "Action": "sts:AssumeRole"
   }
  ]
}
POLICY
}

resource "aws_iam_policy" "workstation" {
  name   = "workstation-route53"
  path   = "/"
  policy = "${data.aws_iam_policy_document.workstation_policy.json}"
}

resource "aws_iam_role_policy_attachment" "workstation" {
  role       = "${aws_iam_role.workstation.name}"
  policy_arn = "${aws_iam_policy.workstation.arn}"
}

data "aws_iam_policy_document" "workstation_policy" {
  statement {
    actions = [
      "route53:*"
    ]

    resources = [
       "*"
    ]
  }
}
