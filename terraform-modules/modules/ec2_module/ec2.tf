resource "aws_instance" "web" {
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = var.key
  subnet_id                   = var.subnet
  vpc_security_group_ids      = var.security_group
  associate_public_ip_address = true

  tags = {
    Name = "webserver"
  }
}