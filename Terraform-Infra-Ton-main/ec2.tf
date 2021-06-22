resource "aws_instance" "apache_webserver" {
  ami                    = data.aws_ami.ubuntu_latest.id
  instance_type          = var.instance_type
  user_data              = file("scripts/install_apache.sh")
  subnet_id              = aws_subnet.private_ec2_a.id
  vpc_security_group_ids = [aws_security_group.sg_ec2_apache.id]
  count                  = var.count_instances

  tags = {
    Name        = "${var.name}-${var.env}"
    app         = var.name
    environment = var.env
    owner       = var.squad
    provisioner = "terraform"

  }
  depends_on = [aws_nat_gateway.nat]

}
