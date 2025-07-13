resource "aws_security_group" "this" {
  name        = var.name
  description = "Security group for SSH access"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_cidr]
  }

  ingress {
    description = "Port 5000 for mongoDB"
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    #cidr_blocks = [var.mongo_cidr]
  }

  tags = {
    Name = var.name
  }
}
