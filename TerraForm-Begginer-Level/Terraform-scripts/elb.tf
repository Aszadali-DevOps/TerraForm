# NLB Creation For Tomcat Server

resource "aws_lb" "nlb_tomcatserver"{
  name = "tomcatserver-nlb"
  internal = "${var.nlb_type}"
  load_balancer_type = "network"
  #security_groups = [aws_security_group.dev.id] For Network Load balancer Security group is not required
  subnets = "${aws_subnet.dev_subnet.*.id}"
  tags = {
    Name = "tomcatserver-nlb"
  }
  depends_on = [
    "aws_subnet.dev_subnet",
    "aws_security_group.dev"
  ]
}

# Target Group Creation For NLB

resource "aws_lb_target_group" "nlb_listener_tomcat" {
  name = "listenertomcat"
  vpc_id = "${aws_vpc.dev_env.id}"
  port = 8080
  protocol = "TCP"
  target_type = "instance"
  health_check {
                port = "8080"
                protocol = "TCP"
                healthy_threshold = 5
                unhealthy_threshold = 2
                interval = 5
                timeout = 4
        } 
        tags = {
          Name = "nlb_listener_tomcat"
        }
        depends_on = [
          "aws_vpc.dev_env"
        ]
}

# Attachement the Target group to NLB

resource "aws_lb_target_group_attachment" "nlb_tg_attchment" {
  count = length(aws_instance.dev_instance)
 target_group_arn = "${aws_lb_target_group.nlb_listener_tomcat.arn}"
 port = "8080"
 target_id = aws_instance.dev_instance[count.index].id
  
}

# Listener creation for NLB

resource "aws_lb_listener" "tomcat_server_nlb_listener" {
  load_balancer_arn = "${aws_lb.nlb_tomcatserver.arn}"
  port = "80"
  protocol = "TCP"
  default_action {
    type = "forward"
    target_group_arn = "${aws_lb_target_group.nlb_listener_tomcat.arn}"
  }
  depends_on = [
    "aws_lb.nlb_tomcatserver",
    "aws_lb_target_group.nlb_listener_tomcat"
  ]
}