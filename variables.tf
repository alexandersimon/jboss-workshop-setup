variable "aws_region" {
  description = "AWS region to create the instances in"
  default     = "eu-central-1"
}

variable "aws_profile" {
  description = "name of the AWS profile to use"
  default     = ""
}

variable "cicd_instance_type" {
  description = "EC2 instance type of the CI/CD node"
  default     = "t2.micro"
}

variable "lb_instance_type" {
  description = "EC2 instance type of the load balancer node"
  default     = "t2.micro"
}

variable "jboss_count" {
  description = "number of JBoss nodes"
  type        = number
  default     = 2
}

variable "jboss_instance_type" {
  description = "EC2 instance type of the JBoss nodes"
  default     = "t2.micro"
}

variable "mon_instance_type" {
  description = "EC2 instance type of the monitoring node"
  default     = "t2.micro"
}
