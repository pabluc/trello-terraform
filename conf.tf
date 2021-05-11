terraform {
  backend "s3" {
    bucket = "terraform-trello"
    key    = "states/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "trello"
  }
}