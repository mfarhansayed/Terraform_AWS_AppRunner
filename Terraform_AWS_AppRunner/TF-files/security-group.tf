#----------------- VPC SECURITY GROUP -------------------------------
resource "aws_default_security_group" "default-sg" {
  count  = var.create_security_group == true ? 1 : 0
  vpc_id = aws_vpc.myvpc[0].id
 
 
  dynamic "ingress" {
    for_each = var.default_security_group_ingress_rules
    content {
      description = "TLS from VPC"
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }
 
  dynamic "egress" {
    for_each = var.default_security_group_egress_rules
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }
 
  tags = {
    project = "project_name"
    Name    = "${var.prefix}-${var.vpc_sg_name}"
  }
 
 
}
 
#----------------- VPC CONNECTOR SECURITY GROUP -------------------------------

resource "aws_security_group" "vpc_connector-sg" {
  count  = var.create_security_group == true ? 1 : 0
  vpc_id = aws_vpc.myvpc[0].id
 
 
  dynamic "ingress" {
    for_each = var.vpc_connector-sg_ingress_rules
    content {
      description = "TLS from VPC"
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }
 
  dynamic "egress" {
    for_each = var.vpc_connector-sg_egress_rules
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }
 
tags = {
    project = "project_name"
    Name    = "${var.prefix}-${var.vpc_connector_sg_name}"
  }  
}
 
#----------------- VPC ENDPOINT SECURITY GROUP -------------------------------

resource "aws_security_group" "vpc_endpoint-sg" {
  count  = var.create_security_group == true ? 1 : 0
  vpc_id = aws_vpc.myvpc[0].id
 
 
  dynamic "ingress" {
    for_each = var.vpc_endpoint-sg_ingress_rules
    content {
      description = "TLS from VPC"
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }
 
  dynamic "egress" {
    for_each = var.vpc_endpoint-sg_egress_rules
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }
 
  tags = {
    project = "project_name"
    Name    = "${var.prefix}-${var.vpc_endpoint_sg_name}"
  }
  
}
  
# ------------------- POSTGRESQL DB SECURITY GROUP ------------------------------------

resource "aws_security_group" "rds_postgres_security_group" {
  count  = var.create_security_group == true ? 1 : 0
  vpc_id = aws_vpc.myvpc[0].id
 
 
  dynamic "ingress" {
    for_each = var.rds_postgres_ingress_rules
    content {
      description = "TLS from VPC"
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }
 
  dynamic "egress" {
    for_each = var.rds_postgres__egress_rules
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }
 
  tags = {
    project = "project_name"
    Name    = "${var.prefix}-${var.rds_postgres_security_group_name}"
  }
  
}
 


