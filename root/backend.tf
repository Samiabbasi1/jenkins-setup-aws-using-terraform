terraform {
  backend "s3" {
    bucket = "remote-backend"
    key    = "backend/terraform.tfstate"
    region = "us-east-1"
  }
}