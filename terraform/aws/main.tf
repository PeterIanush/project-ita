provider "aws" {
  region = "us-east-2"
<<<<<<< HEAD
  access_key = "AKIAI54MQBP62QIWNUVA"
  secret_key = "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"
=======
>>>>>>> 951688de36a8467d3eced25ab7d98b849dabefb0
}

resource "aws_instance" "jenkins" {
  ami           = "ami-0f65671a86f061fcd" 
  instance_type = "t2.micro"
  availability_zone = "us-east-2a"
  key_name = "aws-peter"
  vpc_security_group_ids = ["${aws_security_group.jenkins.id}"]
  associate_public_ip_address = "true"
  tags = {
    Name = "jenkins"
    }
  }

resource "aws_security_group" "jenkins" {
name = "jenkins"
vpc_id = "vpc-969393fe"
description = "Jenkins security group"

tags {
Name = "Jenkins"
}
}

resource "aws_security_group_rule" "jenkins_web_rule" {
type = "ingress"
from_port = "8088"
to_port = "8088"
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
ipv6_cidr_blocks = ["::/0"]
security_group_id = "${aws_security_group.jenkins.id}"
}

resource "aws_security_group_rule" "jenkins_ssh_rule" {
type = "ingress"
from_port = "22"
<<<<<<< HEAD
to_port = "22"
=======
to_port = "2222"
>>>>>>> 951688de36a8467d3eced25ab7d98b849dabefb0
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
ipv6_cidr_blocks = ["::/0"]
security_group_id = "${aws_security_group.jenkins.id}"
}

resource "aws_security_group_rule" "all_egress_jenkins" {
type = "egress"
from_port = "0"
to_port = "0"
protocol = "-1"
cidr_blocks = ["0.0.0.0/0"]
ipv6_cidr_blocks = ["::/0"]
security_group_id = "${aws_security_group.jenkins.id}"
}
