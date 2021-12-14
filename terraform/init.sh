#!/bin/bash
sudo apt update

echo "Install Java JDK 8"
sudo apt install -y openjdk-8-jdk
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

echo "Install Maven"
sudo apt install -y maven 

echo "Install git"
sudo apt install -y git

echo "Install Docker engine"
sudo apt update
sudo apt install -y apt-transport-https
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update
sudo apt install -y docker-ce
sudo usermod -a -G docker ubuntu

echo "Install Jenkins"
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt update
sudo usermod -a -G jenkins ubuntu
sudo usermod -a -G docker jenkins
sudo service jenkins restart

echo "Install Ansible"
sudo apt update
sudo apt install -y ansible
ansible-galaxy collection install amazon.aws
sudo apt update
sudo apt install python3-pip
pip3 install boto3
