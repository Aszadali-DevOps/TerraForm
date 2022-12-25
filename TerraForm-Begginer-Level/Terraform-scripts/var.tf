# Region variable #
variable "reg" {
    type = string
    description = "select the region in aws"
    default = "us-east-1"
}

# Access key for AWS #
 
variable "accessaws" {
    type = string 
    description = "please provide access key"

}

# Secretkey for AWS #

variable "secretaws" {
    type = string
    description = "Secret key for aws"
  
}

# VPC CIDR BLOCK RANGE #

variable "cidrblockvpc" {
    type = string
    description = "please provide the CIDR block"
    default = "172.0.0.0/16"
  
}
# VPC enable_dns_hostnames #

variable "enable_dns" {
    type = bool
    default = true
    
}
# SUBNET RANGE FOR VPC #

variable "cidrsubnet" {
    type = string
    description = "please provide the subnet CIDR block"
    default =  "172.0.192.0/19"
}  

# SUBNET RANGE FOR PRIVATE SUBNET #

variable "cidr_prv_subnet" {
    type = string
    description = "please provide the private CIDR block"
    default = "172.0.254.0/24"
  
}


# AMAZON MACHINE ID #

variable "ami_ec2" {
    type = string
    description = "flavour of ec2"
    default = "ami-08c40ec9ead489470"
  
}

variable  "instance_type" {
    type = string
    description = "type of ec2 instance"
    default = "t2.small"
  
}

variable "key_pair" {
    type = string
    description = "key pair details"
    default = "sbfsajbj"
}

variable "map_ip" {
    type = bool
    description = "Get Public IP for instance which is launched on public subnet"
    default = true  
}

# AVailability zones #

variable "avail_zone" {
    type = list
    description = "AVailabilty zone which requires to create the volume and ELB"
    default = ["us-east-1a","us-east-1b","us-east-1c","us-east-1d","us-east-1e","us-east-1f"]
}

variable size {
    type = number
    description = "Size of the EBS volume"
    default = 10
}

variable "type" {
    type = string
    description = "Type of the EBS volume"
    default = "gp2"
  
}

variable "device_name" {
    type = string
    description = "device name of ebs"
    default = "/dev/sdh/"
}

# NLB Type i.e Internal or External

variable "nlb_type" {
    type = bool
    default = false
  
}