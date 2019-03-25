# Description

Based on updated terraform modules by [Cloud Posse](https://github.com/cloudposse).

# Usage

1. Copy terraform.tfvars.example to terraform.tfvars
2. Update terraform.tfvars

        aws_profile = "rmdev"
        vpc_name = "test-vpc"
        vpc_cidr = "10.100.0.0/16"
        region = "ap-southeast-1"
        public_key = "ssh-rsa XXXX"
3. Run

        terraform init
        terraform apply
        
4. Deploy the uploaded version

![](images/deploy.png?raw=true)


# Screenshots

![](images/beanstalk1.png?raw=true)
![](images/beanstalk2.png?raw=true)
![](images/nat.png?raw=true)
![](images/route53.png?raw=true)
![](images/subnets.png?raw=true)
