# AWS vpc creation #

resource "aws_vpc" "dev_env" {
    cidr_block = "${var.cidrblockvpc}"
    instance_tenancy = "default"
    enable_dns_hostnames = "${var.enable_dns}"
    tags = {
        Name = "Dev_VPC"
    }
  
}