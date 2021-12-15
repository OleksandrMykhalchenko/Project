resource "aws_instance" "deployment-instance" {
  ami             = "${var.instance_ami}"
  instance_type   = "${var.instance_type}"
  key_name        = "${var.keyname}"
  vpc_security_group_ids = ["${aws_security_group.sg_allow_ssh_deployment.id}"]
  subnet_id          = "${aws_subnet.public-subnet-1.id}"
  associate_public_ip_address = true

  tags = {
    Name = "Deployment-Instance"
    Env = "Deploy"
  }
}

resource "aws_security_group" "sg_allow_ssh_deployment" {
  name        = "allow_ssh_deployment"
  description = "Allow SSH and Deployment inbound traffic"
  vpc_id      = "${aws_vpc.development-vpc.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "jenkins-instance" {
  ami             = "${var.instance_ami}"
  instance_type   = "${var.instance_type}"
  key_name        = "${var.keyname}"
  vpc_security_group_ids = ["${aws_security_group.sg_allow_ssh_jenkins.id}"]
  subnet_id          = "${aws_subnet.public-subnet-2.id}"
  associate_public_ip_address = true

  user_data = "${file("init.sh")}"
  
  tags = {
    Name = "Jenkins-Instance"
  }
}

resource "aws_security_group" "sg_allow_ssh_jenkins" {
  name        = "allow_ssh_jenkins"
  description = "Allow SSH and Jenkins inbound traffic"
  vpc_id      = "${aws_vpc.development-vpc.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

  output "jenkins_ip_address" {
    value = "${aws_instance.jenkins-instance.public_dns}"
  }

    output "deployment_ip_address" {
    value = "${aws_instance.deployment-instance.public_dns}"
  }

resource "aws_instance" "development-instance" {
  ami             = "${var.instance_ami}"
  instance_type   = "${var.instance_type_deploy}"
  key_name        = "${var.keyname}"
  vpc_security_group_ids = ["${aws_security_group.sg_allow_ssh_deployment.id}"]
  subnet_id          = "${aws_subnet.public-subnet-1.id}"
  associate_public_ip_address = true

  tags = {
    Name = "Development-Instance"
    Env = "Develop"
  }
}
