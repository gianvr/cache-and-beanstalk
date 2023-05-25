resource "aws_elastic_beanstalk_application" "application" {
  name        = "app-beanstalk"
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
  name                = "beanstalk-environment"
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
  setting {
       name      = "DeleteOnTerminate"
       namespace = "aws:elasticbeanstalk:cloudwatch:logs"
       value     = "true"
     }
  setting {
      name      = "HealthStreamingEnabled"
      namespace = "aws:elasticbeanstalk:cloudwatch:logs:health"
      value     = "true"
    }
  setting {
      name      = "StreamLogs"
      namespace = "aws:elasticbeanstalk:cloudwatch:logs"
      value     = "true"
    }
  setting {
      name      = "ConfigDocument"
      namespace = "aws:elasticbeanstalk:healthreporting:system"
      value     = file("${path.module}/healthcheck.json")
  }
}


resource "aws_elastic_beanstalk_application_version" "default" {
  name        = "versao-teste"
  application = "app-beanstalk"
  description = "application version created by terraform"
  bucket      = aws_s3_bucket.bucket_applicationversion.id
  key         = aws_s3_object.bucket_object.id
}
