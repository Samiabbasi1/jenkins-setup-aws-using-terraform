variable "bucket_name" {
  type        = string
  description = "remote-backend"
}
variable "vpc_cidr" {
  type        = string
  description = "cidr value for vpc"
}
variable "vpc_name" {
  type        = string
  description = "vpc's name"
}
variable "cidr_public" {
  type        = list(string)
  description = "cidr value for public subnet"
}
variable "cidr_private" {
  type        = list(string)
  description = "cidr value for private subnet"
}
variable "pub_key" {
  type        = string
  description = "public key for ec2 instance"
}
variable "ec2_ami" {
  type        = string
  description = "ami-id for ec2 instance"
}
variable "us_availibility_zone" {
  type        = list(string)
  description = "availibility zones"
}
