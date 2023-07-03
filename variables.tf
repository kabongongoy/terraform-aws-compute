#----------------------------compute\variables ----------------------------------

variable "instance_type" {
  default = "t3.micro"
}

variable "instance_count" {
  type    = number
  default = 1
}

variable "key_name" {
  default = "kabkey"
}

variable "volume_size" {
  type    = number
  default = 10
}

variable "public_key_path" {
  default = "./kabkey.pub"
}

variable "aws_region" {
  default = "us-east-1"
}