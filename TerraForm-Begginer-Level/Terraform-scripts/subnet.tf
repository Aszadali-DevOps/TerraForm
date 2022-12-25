# SUBNET FOR VPC #

resource "aws_subnet" "dev_subnet" {
    vpc_id = "${aws_vpc.dev_env.id}"
    cidr_block = "${var.cidrsubnet}"
    tags = {
        Name = "dev_subnet_pub"
    }  
    depends_on = [
      "aws_vpc.dev_env"
    ]
}

# ROUTING TABLE RULE #

resource "aws_route_table" "pub_route" {
   vpc_id = "${aws_vpc.dev_env.id}"
   route  {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.dev_igw.id}"
   }
   tags = {
    Name = "dev_pub_route_table"
   }
   depends_on = [
     "aws_vpc.dev_env",
     "aws_internet_gateway.dev_igw"
   ]
   
}

# ROUTE ASSOCIATION WITH PUBLIC SUBNET #

resource "aws_route_table_association" "dev_rt_ass" {
    subnet_id = "${aws_subnet.dev_subnet.id}"
    route_table_id = "${aws_route_table.pub_route.id}"
    depends_on = [
      "aws_subnet.dev_subnet",
      "aws_route_table.pub_route"
    ]

  
}

# SUBNET PRIVATE #

resource "aws_subnet" "dev_prv_subnet" {
    vpc_id = "${aws_vpc.dev_env.id}"
    cidr_block = "${var.cidr_prv_subnet}"
    tags = {
        Name = "dev_private_subnet"
    }
  depends_on = [
    "aws_vpc.dev_env"
  ]
}

# Route TABle Creation for Private Subnet#

resource "aws_route_table" "dev_priv_rt" {
   vpc_id ="${aws_vpc.dev_env.id}"
   route  {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.dev_natgateway.id}"
   }
   depends_on = [
     "aws_vpc.dev_env",
     "aws_subnet.dev_prv_subnet",
     "aws_nat_gateway.dev_natgateway"
   ]
}

# ROUTE TABLE ASSOCIATIOn FOR Private SUBNET #

resource "aws_route_table_association" "dev_priv_rt_subass" {
    subnet_id = "${aws_subnet.dev_prv_subnet.id}"
    route_table_id = "${aws_route_table.dev_priv_rt.id}"
    depends_on = [
      "aws_subnet.dev_prv_subnet",
      "aws_route_table.dev_priv_rt"
    ]

  
}