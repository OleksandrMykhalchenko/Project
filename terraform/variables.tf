variable "region" {
  default = "us-east-1"
}
variable "environment" {
  default = "Development"
}
variable "vpc_cidr" {
  description = "VPC cidr block"
  default = "10.0.0.0/16"
}
variable "public_subnet_1_cidr" {
  description = "Public Subnet 1 cidr block"
  default = "10.0.1.0/24"
}
variable "public_subnet_2_cidr" {
  description = "Public Subnet 2 cidr block"
  default = "10.0.2.0/24"
}
variable "instance_type" {
  default = "t3.medium"
}
variable "instance_ami" {
  default = "ami-083654bd07b5da81d"
}
variable "keyname" {
  default = "main-key"
}