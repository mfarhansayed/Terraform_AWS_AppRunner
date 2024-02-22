#----------------------VPC--------------------------------------

resource "aws_vpc" "myvpc" {
  count                = var.create_vpc == true ? 1 : 0
  cidr_block           = var.vpc_cidr
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  tags = {
    project = "project_name"
    Name    = "${var.prefix}-${var.vpc_name}"
  }
}

#---------------SUBNETS-------------------------------

resource "aws_subnet" "subnet" {
  count             = var.create_subnets ? length(var.subnets) : 0
  cidr_block        = var.subnets[keys(var.subnets)[count.index]].cidr_block
  vpc_id            = aws_vpc.myvpc[0].id
  availability_zone = var.subnets[keys(var.subnets)[count.index]].availability_zone

  tags = {
    project = "project_name"
    Name    = var.subnets[keys(var.subnets)[count.index]].tag_name
  }
}

#-------------------INTERNET-GATEWAY---------------------------

resource "aws_internet_gateway" "myIgw" {
  count  = var.create_internet_gateway == true ? 1 : 0
  vpc_id = aws_vpc.myvpc[0].id
  tags = {
    project = "project_name"
    Name    = "${var.prefix}-${var.ig_name}"
  }

}

#------------------- Route Tables for public subnet--------------------

resource "aws_route_table" "PublicRT" {
  count  = var.create_route_table == true ? 1 : 0
  vpc_id = aws_vpc.myvpc[0].id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myIgw[0].id

  }

  tags = {
    project = "project_name"
    Name    = "${var.prefix}-${var.route-table[0]}"
  }

}

#------------------- Route Tables for private subnet--------------------
resource "aws_route_table" "PrivateRT" {

  depends_on = [
    aws_nat_gateway.NAT_GATEWAY
  ]

  vpc_id = aws_vpc.myvpc[0].id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.NAT_GATEWAY[0].id

  }


  tags = {
    project = "project_name"
    Name    = "${var.prefix}-${var.route-table[1]}"
  }
}

# ---- Creating a resource for the Route Table Association PublicRT!  ------
resource "aws_route_table_association" "first_subnet_association" {
  count          = var.create_route_table == true ? 1 : 0
  subnet_id      = aws_subnet.subnet[0].id
  route_table_id = aws_route_table.PublicRT[0].id
}

resource "aws_route_table_association" "third_subnet_association" {
  count          = var.create_route_table == true ? 1 : 0
  subnet_id      = aws_subnet.subnet[2].id
  route_table_id = aws_route_table.PublicRT[0].id
}


# ---- Creating a resource for the Route Table Association PrivateRT!  ------

resource "aws_route_table_association" "second_subnet_association" {
  depends_on = [
    aws_route_table.PrivateRT
  ]

  subnet_id      = aws_subnet.subnet[1].id
  route_table_id = aws_route_table.PrivateRT.id
}

resource "aws_route_table_association" "fourth_subnet_association" {
  depends_on = [
    aws_route_table.PrivateRT
  ]
  subnet_id      = aws_subnet.subnet[3].id
  route_table_id = aws_route_table.PrivateRT.id
}

#--------------- Elastic IP for the NAT Gateway -----------------------
resource "aws_eip" "Nat-Gateway-EIP1" {
  count  = var.create_eip == true ? 1 : 0
  domain = "vpc"
  tags = {
    project = "project_name"
    Name    = "${var.prefix}-${var.elasticip}"
  }

}

#------------------- NAT Gateway --------------------------------
resource "aws_nat_gateway" "NAT_GATEWAY" {
  depends_on = [
    aws_eip.Nat-Gateway-EIP1
  ]
  count = var.create_eip == true ? 1 : 0
  # Allocating the Elastic IP to the NAT Gateway!
  allocation_id = aws_eip.Nat-Gateway-EIP1[0].id
  # Associating it in the Public Subnet!
  subnet_id = aws_subnet.subnet[0].id
  tags = {
    project = "project_name"
    Name    = "${var.prefix}-${var.nat-gateway_name}"
  }
}









