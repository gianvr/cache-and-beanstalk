
<div align = "center">

  # Cache and Beanstalk
  
  <img src='img/logo.png' style="width:17rem;"/>
  


![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white)
![AWS](https://img.shields.io/badge/Amazon_AWS-232F3E?style=for-the-badge&logo=amazon-aws&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)
![Flask](https://img.shields.io/badge/Flask-000000?style=for-the-badge&logo=flask&logoColor=white)
  
## [Full documentation here](https://gianvr.github.io/cache-and-beanstalk-docs/)
  
## Infrastructure architecture

<img src='img/architecture.png' style="width:50rem;"/>
  
 </div>
 
## Requirements 

- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) 
- [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)

## Commands (in `./terraform`)

1. To initialize Terraform:
```bash
terraform init
```
2. To generate the execution plan
```bash
terraform plan
```
3. To build the infrastructure
```bash
terraform apply --auto-approve
```

4. To deploy the application
```bash
aws elasticbeanstalk update-environment --application-name app-beanstalk --version-label v1 --environment-name beanstalk-environment
```

5. To destroy the infrastructure
```bash
terraform destroy --auto-approve
```
