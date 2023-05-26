module "elastic_beanstalk" {
    source = "./elastic_beanstalk"
    redis_endpoint = module.elastic_cache.redis_endpoint
    bucket_id = module.s3.bucket_id
    bucket_object_id = module.s3.bucket_object_id
}

module "elastic_cache" {
    source = "./elastic_cache"
    security_groud_id = module.elastic_beanstalk.allow_redis_id
}

module "s3" {
    source = "./s3"   
}

module "iam" {
    source = "./iam"   
}

module "cloudwatch" {
    source = "./cloudwatch"
    beanstalk_autoscaling_group = module.elastic_beanstalk.beanstalk_autoscaling_group
    cluster_id = module.elastic_cache.cluster_id
    environment_name = var.environment_name
}
