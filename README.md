# Description

Based on updated terraform modules by [Cloud Posse](https://github.com/cloudposse).

# Usage

1. Set environment variables

        AWS_PROFILE=<AWS_PROFILE_NAME>
        AWS_DEFAULT_REGION=ap-southeast-1
2. Copy terraform.tfvars.example to terraform.tfvars
3. Update terraform.tfvars

        aws_profile = "rmdev"
        vpc_name = "test-vpc"
        vpc_cidr = "10.100.0.0/16"
        region = "ap-southeast-1"
        public_key = "ssh-rsa XXXX"
4. Run

        terraform init
        terraform apply
        
5. Deploy the uploaded version

![](images/deploy.png?raw=true)


# Screenshots

![](images/beanstalk1.png?raw=true)
![](images/beanstalk2.png?raw=true)
![](images/nat.png?raw=true)
![](images/route53.png?raw=true)
![](images/subnets.png?raw=true)
