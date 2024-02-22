resource "aws_vpc_endpoint" "apprunner" {
  count               = var.create_vpc_endpoint == true ? 1 : 0
  vpc_id              = aws_vpc.myvpc[0].id
  service_name        = var.vpc_endpoint_service_name
  vpc_endpoint_type   = var.vpc_endpoint_type
  subnet_ids          = [aws_subnet.subnet[1].id, aws_subnet.subnet[3].id]
  security_group_ids  = [aws_security_group.vpc_endpoint-sg[0].id]
  private_dns_enabled = false

  tags = {
    project = "project_name"
    Name    = "${var.prefix}-${var.vpc_endpoint_name}"
  }
}

