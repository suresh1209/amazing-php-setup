variable "AWS_REGION" {
  default = "eu-west-1"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "glofox"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "glofox.pub"
}

variable "AMIS" {
  type = "map"

  default = {
    us-east-1 = "ami-13be557e"
    us-west-2 = "ami-06b94666"
    eu-west-1 = "ami-76dfa60f"
  }
}
