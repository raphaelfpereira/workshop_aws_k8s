variable "AWS_REGION" {
  default = "us-east-1"
}
variable "NAME" {
  default = "curinga0.tk"
}
variable "KOPS_STATE" {
  default = "kops-curinga0.tk"
}
variable "ENVIRONMENT" {
  default = "Development"
}
variable "CIDR_VPC" {
  default = "10.0.0.0/16"
}
variable "AZS" {
  default = ["us-east-1a"]
}
variable "PRIVATE_SUBNETS" {
  default = ["10.0.1.0/24"]
}
variable "PUBLIC_SUBNETS" {
  default = ["10.0.101.0/24"]
}