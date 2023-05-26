resource "aws_elastic_beanstalk_application" "application" {
  name        = var.app_name
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
  name                = var.environment_name
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
    value     = var.redis_endpoint
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


resource "aws_elastic_beanstalk_application_version" "app_version" {
  name        = var.app_version
  application = var.app_name
  description = var.app_version_description
  bucket      = var.bucket_id
  key         = var.bucket_object_id
}
