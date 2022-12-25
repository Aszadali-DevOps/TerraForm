# ELastic Ip Creation #

resource "aws_eip" "dev_eip" {
    vpc = true
    tags = {
        Name = "DEV_IP"
    }
  
}