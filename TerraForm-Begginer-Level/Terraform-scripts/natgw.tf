# NAT GATEWAY CREATION #

resource "aws_nat_gateway" "dev_natgateway" {
    allocation_id = "${aws_eip.dev_eip.id}"
    subnet_id = "${aws_subnet.dev_subnet.id}"
    tags = {
        Name = "dev_NATGW"
    }
  depends_on = [
    "aws_eip.dev_eip",
    "aws_subnet.dev_subnet"
  ]
}