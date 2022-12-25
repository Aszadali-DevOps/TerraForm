# Resource ec2 creation #

resource "aws_instance" "dev_instance" {
    ami  = "${var.ami_ec2}"
    instance_type = "${var.instance_type}"
    key_name = "${var.key_pair}"
    vpc_security_group_ids = [aws_security_group.dev.id]
    subnet_id = "${aws_subnet.dev_subnet.id}"
    tags = {
        Name = "Nginx-server"
    }
     user_data = <<-EOF
     #!/bin/bash
     apt update -y
     apt install nginx -y
     systemctl enable nginx 
     EOF
     
}

# Jenkins Instance Creation #

resource "aws_instance" "jenkins_dev" {
    ami = "${var.ami_ec2}"
    instance_type = "${var.instance_type}"
    key_name = "${var.key_pair}"
    vpc_security_group_ids = [aws_security_group.dev.id]
    subnet_id = "${aws_subnet.dev_prv_subnet.id}"
    availability_zone = "${var.avail_zone[3]}"
    tags = {
        Name = "Jenkins-server"
    }
    user_data = <<-EOF
    #!/bin/bash
    apt update -y
    apt install default-jdk -y
    curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
  echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
  apt-get update -y
  apt install jenkins -y
  systemctl enable jenkins
  systemctl start jenkins
  EOF

  
}