resource "aws_security_group" "project_sc" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = var.project_vpc

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }
  // Remove the default rule
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "expose-3000" {
  security_group_id = aws_security_group.project_sc.id
  type              = "ingress"
  from_port         = 3000
  to_port           = 3000
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "expose-5050" {
  security_group_id = aws_security_group.project_sc.id
  type              = "ingress"
  from_port         = 5050
  to_port           = 5050
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}