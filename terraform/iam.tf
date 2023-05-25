data "aws_iam_policy" "managed_policy" {
  name     = "AWSElasticBeanstalkWebTier"
}

resource "aws_iam_role" "beanstalk" {
  name = "iam_for_beanstalk"
  assume_role_policy = file("${path.module}/assumerole.json")
  managed_policy_arns = [data.aws_iam_policy.managed_policy.arn]
}
 
resource "aws_iam_instance_profile" "beanstalk_instance_profile" {
  name = "aws-elasticbeanstalk-ec2-role"
  role = aws_iam_role.beanstalk.name
}