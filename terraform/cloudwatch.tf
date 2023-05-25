resource "aws_cloudwatch_metric_alarm" "requests" {
    alarm_name = "beanstalk-requests"
    alarm_description = "This metric monitors application requests"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    threshold = 5
    evaluation_periods = 1
    metric_name = "ApplicationRequestsTotal"
    namespace = "AWS/ElasticBeanstalk"
    period = 60
    statistic = "Average"
    dimensions = {
        EnvironmentName = aws_elastic_beanstalk_environment.environment.name
    }
}

resource "aws_cloudwatch_metric_alarm" "environment_health" {
    alarm_name = "beanstalk-environment-health"
    alarm_description = "This metric monitors environment health"
    comparison_operator = "GreaterThanThreshold"
    threshold = 1
    evaluation_periods = 2
    metric_name = "EnvironmentHealth"
    namespace = "AWS/ElasticBeanstalk"
    period = 60
    statistic = "Average"
    dimensions = {
        EnvironmentName = aws_elastic_beanstalk_environment.environment.name
    }
  
}

resource "aws_cloudwatch_metric_alarm" "cache_capacity" {
    alarm_name = "beanstalk-cache-capacity"
    alarm_description = "This metric monitors cache capacity"
    comparison_operator = "GreaterThanThreshold"
    threshold = 75
    evaluation_periods = 1
    metric_name = "DatabaseCapacityUsagePercentage"
    namespace = "AWS/ElastiCache"
    period = 60
    statistic = "Average"
    dimensions = {
        CacheClusterId = aws_elasticache_cluster.example.id
    }
}

resource "aws_cloudwatch_metric_alarm" "cache_cpu" {
    alarm_name = "beanstalk-cache-cpu"
    alarm_description = "This metric monitors cache cpu usage"
    comparison_operator = "GreaterThanThreshold"
    threshold = 75
    evaluation_periods = 1
    metric_name = "CPUUtilization"
    namespace = "AWS/ElastiCache"
    period = 60
    statistic = "Average"
    dimensions = {
        CacheClusterId = aws_elasticache_cluster.example.id
    }
}

resource "aws_cloudwatch_metric_alarm" "cache_network_in" {
    alarm_name = "cache_network_in"
    alarm_description = "This metric monitors cache network in"
    comparison_operator = "GreaterThanThreshold"
    threshold = 2000000 # 2MB
    evaluation_periods = 1
    metric_name = "NetworkBytesIn"
    namespace = "AWS/ElastiCache"
    period = 60
    statistic = "Sum"
    dimensions = {
        CacheClusterId = aws_elasticache_cluster.example.id
    }
}

resource "aws_cloudwatch_metric_alarm" "cache_network_out" {
    alarm_name = "cache_network_out"
    alarm_description = "This metric monitors cache network out"
    comparison_operator = "GreaterThanThreshold"
    threshold = 2000000 # 2MB
    evaluation_periods = 1
    metric_name = "NetworkBytesOut"
    namespace = "AWS/ElastiCache"
    period = 60
    statistic = "Sum"
    dimensions = {
        CacheClusterId = aws_elasticache_cluster.example.id
    }
}

resource "aws_cloudwatch_metric_alarm" "cache_misses" {
    alarm_name = "cache_misses"
    alarm_description = "This metric monitors cache misses"
    comparison_operator = "GreaterThanThreshold"
    threshold = 5
    evaluation_periods = 1
    metric_name = "CacheMisses"
    namespace = "AWS/ElastiCache"
    period = 60
    statistic = "Average"
    dimensions = {
        CacheClusterId = aws_elasticache_cluster.example.id
    }
}


resource "aws_cloudwatch_metric_alarm" "cpu_auto_scaling" {
    alarm_name = "beanstalk-cpu-auto-scaling"
    alarm_description = "This metric monitors cpu usage auto scaling"
    comparison_operator = "GreaterThanThreshold"
    threshold = 75
    evaluation_periods = 1
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    period = 60
    statistic = "Average"
    dimensions = {
        AutoScalingGroupName = aws_elastic_beanstalk_environment.environment.autoscaling_groups[0]
    }
}

resource "aws_cloudwatch_metric_alarm" "credit_balance_auto_scaling" {
    alarm_name = "credit_balance_auto_scaling"
    alarm_description = "This metric monitors credit balance auto scaling"
    comparison_operator = "LessThanOrEqualToThreshold"
    threshold = 10
    evaluation_periods = 1
    metric_name = "CPUCreditBalance"
    namespace = "AWS/EC2"
    period = 60
    statistic = "Minimum"
    dimensions = {
        AutoScalingGroupName = aws_elastic_beanstalk_environment.environment.autoscaling_groups[0]
    }
}

resource "aws_cloudwatch_metric_alarm" "credit_usage_auto_scaling" {
    alarm_name = "credit_usage_auto_scaling"
    alarm_description = "This metric monitors credit usage auto scaling"
    comparison_operator = "GreaterThanThreshold"
    threshold = 80
    evaluation_periods = 1
    metric_name = "CPUCreditUsage"
    namespace = "AWS/EC2"
    period = 60
    statistic = "Maximum"
    dimensions = {
        AutoScalingGroupName = aws_elastic_beanstalk_environment.environment.autoscaling_groups[0]
    }
}