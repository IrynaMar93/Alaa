resource "aws_key_pair" "my_key_pair" {
  key_name   = "my_key_name"
  public_key = file("~/.ssh/id_rsa.pub")
}

variable "key" {
    type = string
    default = "my_key_name"
  }