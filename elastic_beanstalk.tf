resource "aws_elastic_beanstalk_application" "application" {
  name        = "app-beanstalk"
  
}
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

resource "aws_elastic_beanstalk_environment" "environment" {
  name                = "beanstalk-env"
  application         = aws_elastic_beanstalk_application.application.name
  solution_stack_name = "64bit Amazon Linux 2 v3.5.2 running Python 3.8"

  setting {
        namespace = "aws:autoscaling:launchconfiguration"
        name      = "IamInstanceProfile"
        value     = "aws-elasticbeanstalk-ec2-role"
      }
  # setting {
  #   namespace = "aws:elasticbeanstalk:application:environment"
  #   name      = "REDIS_ENDPOINT"
  #   value     = aws_elasticache_replication_group.cache_replication_group_beanstalk.primary_endpoint_address
  # }
}

resource "aws_s3_bucket" "bucket_applicationversion" {
  bucket = "bucket-applicationversion"
}

resource "aws_s3_object" "bucket_object" {
  bucket = aws_s3_bucket.bucket_applicationversion.id
  key    = "app.zip"
  source = "application.zip"
}

resource "aws_elastic_beanstalk_application_version" "default" {
  name        = "versao-teste"
  application = "app-beanstalk"
  description = "application version created by terraform"
  bucket      = aws_s3_bucket.bucket_applicationversion.id
  key         = aws_s3_object.bucket_object.id
}

output "aws_command" {
  value = "aws elasticbeanstalk update-environment --application-name ${aws_elastic_beanstalk_application.application.name} --version-label ${aws_elastic_beanstalk_application_version.default.name} --environment-name ${aws_elastic_beanstalk_environment.environment.name}"
}

# resource "aws_vpc" "vpc" {
#   cidr_block = "10.0.0.0/16"
# }

# resource "aws_subnet" "subnet_cache" {
#   vpc_id            = aws_vpc.vpc.id
#   cidr_block        = "10.0.0.0/24"
#   availability_zone = "us-east-1a"
# }

# resource "aws_elasticache_subnet_group" "subnet_group_cache" {
#   name       = "subnet-group-cache"
#   subnet_ids = [aws_subnet.subnet_cache.id]
# }

# resource "aws_elasticache_replication_group" "cache_replication_group_beanstalk" {
#   replication_group_id = "cache-replication-group-beanstalk"
#   description          = "beanstalk-redis"
#   node_type            = "cache.m4.large"
#   port                 = 6379
#   subnet_group_name    = aws_elasticache_subnet_group.subnet_group_cache.name
# }