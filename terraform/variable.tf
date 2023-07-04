variable "aws_region" {
  description = "regions my resources will be deployed"
  type        = string
  default     = "ap-northeast-1a"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "ami" {
  type    = string
  default = "ami-04581fbf744a7d11f"
}

variable "key_name" {
  type    = string
  default = "myec2key"
}

variable "s3bucket" {
  type    = string
  default = "jenkins-bucket-31032023369432"
}

variable "acl" {
  type    = string
  default = "private"
}

variable "vpc_id" {
  type    = string
  default = "vpc-084f2b2f58db22b55"
}