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

resource "aws_security_group" "allow_redis" {
  name      = "allow_redis"
  ingress  {
    description =  "Allow Redis" 
    from_port        = 6379
    to_port          = 6379
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

resource "aws_elastic_beanstalk_environment" "environment" {
  name                = "beanstalk-env"
  application         = aws_elastic_beanstalk_application.application.name
  solution_stack_name = "64bit Amazon Linux 2023 v4.0.0 running Python 3.11"


  setting {
        namespace = "aws:autoscaling:launchconfiguration"
        name      = "IamInstanceProfile"
        value     = "aws-elasticbeanstalk-ec2-role"
      }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "REDIS_ENDPOINT"
    value     = aws_elasticache_cluster.example.cache_nodes.0.address
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "SecurityGroups"
    value     = aws_security_group.allow_redis.name
  }
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

resource "aws_elasticache_cluster" "example" {
  cluster_id           = "cluster-example"
  engine               = "redis"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis7"
  port                 = 6379
  security_group_ids   = [aws_security_group.allow_redis.id]
}
