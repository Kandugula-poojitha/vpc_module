variable "cidr_block" {
  description = "cidr for aws vpc"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet-public-cidr_block" {
  description = "subnet-public-cidr_block"
  type        = string
  default     = "10.0.1.0/24"
}
variable "subnet-private-cidr_block" {
  description = "subnet-private-cidr_block"
  type        = string
  default     = "10.0.3.0/24"
}

variable "ami_id" {
  description = "give your ami value"
  type = string
  default = "ami-xxxxxxxxxxxxx"
  
}
variable "instance_type" {
  description = "give your instance type"
  type = string  
}
variable "create_ec2" {
   description = "create ec2 or not"
  type        = bool
  default     = true
}

variable "count_ec2_instance" {
   description = "give number of instances you want to create "
  type        = number
  default     = 2
}
