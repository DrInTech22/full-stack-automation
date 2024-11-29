variable "aws_region" {
  description = "AWS region to deploy resources"
  default     = "us-east-1"
}

variable "vpc-name" {
  description = "Name of the VPC"
  default     = "MainVPC"
}

variable "subnet-name" {
  description = "Name of the Subnet"
  default     = "MainSubnet"
}

variable "igw-name" {
  description = "Name of the Internet Gateway"
  default     = "MainIGW"
}

variable "rt-name" {
  description = "Name of the Route Table"
  default     = "MainRouteTable"
}

variable "sg-name" {
  description = "Name of the Security Group"
  default     = "MainSG"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "key_pair_name" {
  description = "Key pair name for SSH access"
  type        = string
}

variable "private_key_path" {
  description = "private key path for ansible ssh access"
  type        = string
}

variable "ec2_name" {
  description = "Name of the EC2 instance"
  default     = "MainEC2Instance"
}
