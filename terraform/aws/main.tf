provider "aws" {
  region = "us-east-2"
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

 provisioner "remote-exec" {
       connection {
        agent       = false
        type        = "ssh"
        user        = "ubuntu"
        private_key = "${file("./var/aws-peter.pem")}"
        timeout     = "1m"
      }

       inline = [
        "sudo apt-get install -y python-software-properties debconf-utils",
        "sudo add-apt-repository -y ppa:webupd8team/java",
        "sudo apt-get update",
        "echo 'oracle-java8-installer shared/accepted-oracle-license-v1-1 select true' | sudo debconf-set-selections",
        "sudo apt-get install -y oracle-java8-installer",
        "wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -",
        "sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'",
        "sudo apt-get install -qy maven",
        "sudo apt -qy update",
        "echo 'install jenkins'",
        "sudo apt install -qy jenkins",
        "echo 'restart j'",
        "sudo systemctl start jenkins",
        "sudo cat /var/lib/jenkins/secrets/initialAdminPassword",
       ]
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
from_port = "8080"
to_port = "8080"
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
ipv6_cidr_blocks = ["::/0"]
security_group_id = "${aws_security_group.jenkins.id}"
}

resource "aws_security_group_rule" "jenkins_ssh_rule" {
type = "ingress"
from_port = "22"
to_port = "22"
to_port = "22"
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
