terraform {
  backend "s3" {
    bucket = "itss-devops-ojt-tfstate"
    key    = "tfstate-devops-ojt-pagharion-module"
    region = "ap-southeast-1"
  }
}