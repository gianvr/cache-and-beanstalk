output "allow_redis_id" {
    value = aws_security_group.allow_redis.id
}

output "beanstalk_autoscaling_group" {
    value = aws_elastic_beanstalk_environment.environment.autoscaling_groups[0]
}
