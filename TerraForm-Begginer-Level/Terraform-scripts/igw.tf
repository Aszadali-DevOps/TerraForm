# INTERNET GATEWAY ID #

resource "aws_internet_gateway" "dev_igw" {
    vpc_id = "${aws_vpc.dev_env.id}"
    tags = {
        Name = "Dev_IGW"
    }
  
}