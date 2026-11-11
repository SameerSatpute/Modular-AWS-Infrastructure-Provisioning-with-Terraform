module "s3" {
    source = "./modules/s3"
    bucketname = "bababababbaa"
    bucket_namespace = "global"
    object_ownership = "BucketOwnerEnforced"
    versioning = "Enabled"
    prefix = "logs/"
    day = 90
    storage_class = "GLACIER"
    days = 180
    noncurrent_days = 90
}

module "security_group" {
    source = "./modules/security_group"
    vpc_id = module.vpc.vpc_id
    cidripv4 = "0.0.0.0/0"
    ssh = 22
    ssh1 = 22
    protocol = "tcp"
}

module "vpc" {
    source = "./modules/vpc"
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    region = "ap-south-1"
    subnet_name = "subnet1"
    availability_zone = "ap-south-1a"
    subnet1cidr_block = "10.0.1.0/24"
    subnet1publicip = true
    availability_zone2 = "ap-south-1b"
    subnet2cidr_block = "10.0.2.0/24"
    subnet_name2 = "subnet2"
    routetablecidr = "0.0.0.0/0" 
    service_name = "com.amazonaws.ap-south-1.s3"
    type = "Gateway"   
}

module "iam" {
    source = "./modules/iam"
    policy = "Service"
    identifier = ["ec2.amazonaws.com"]
    rolename = "ec2roles3"
    arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
    instance_profile = "ec2tos3"
}

module "ec2" {
    source = "./modules/ec2"
    key_name = "key-ec2"
    public_key = "C:/Users/asus/OneDrive/Desktop/terraform/terraform/key-ec2.pub"
    
    ec2 = {
        public = {
            ami                = "ami-0f19324397f53458f"
            instance_type      = "t3.micro"
            subnet_id          = module.vpc.subnet_name.id
            public_ip          = true
            security_group_ids = [module.security_group.id]
            volume_size        = 20
            volume_type        = "gp3"
        }
        private = {
            ami                = "ami-0f19324397f53458f"
            instance_type      = "t2.micro"
            subnet_id          = module.vpc.subnet_name2.id
            public_ip          = false
            security_group_ids = [module.security_group.id]
            volume_size        = 10
            volume_type        = "gp3"
            instance_profile   = module.iam.instance_profile.id
        }
    }
}