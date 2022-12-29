resource "aws_vpc" "this_vpc" {
  cidr_block       = var.cidr_block
  instance_tenancy = var.instance_tenancy
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "this_public_subnet" {
  vpc_id            = aws_vpc.this_vpc.id
  cidr_block        = element(var.public_subnet_cidr, count.index)
  availability_zone = element(var.availability_zone, count.index)
  count             = length(var.public_subnet_cidr)
}

resource "aws_subnet" "this_private_subnet" {
  vpc_id            = aws_vpc.this_vpc.id
  cidr_block        = element(var.private_subnet_cidr, count.index)
  availability_zone = element(var.availability_zone, count.index)
  count             = length(var.private_subnet_cidr)
}

resource "aws_internet_gateway" "this_igw" {
  vpc_id = aws_vpc.this_vpc.id

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_eip" "eip_for_ngw" {
  vpc = true
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_nat_gateway" "this_ngw" {
  allocation_id = aws_eip.eip_for_ngw.id
  subnet_id     = aws_subnet.this_public_subnet[0].id
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.this_vpc.id
}
resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this_igw.id
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.this_vpc.id
}

resource "aws_route" "private_route" {
  route_table_id = aws_route_table.private_route_table.id

  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.this_ngw.id
}

resource "aws_route_table_association" "public_rtb_asso" {
  count          = length(var.public_subnet_cidr)
  subnet_id      = aws_subnet.this_public_subnet[count.index].id
  route_table_id = aws_route_table.public_route_table.id
 
}

resource "aws_route_table_association" "private_rtb_asso" {
  count          = length(var.private_subnet_cidr)
  subnet_id      = aws_subnet.this_private_subnet[count.index].id
  route_table_id = aws_route_table.private_route_table.id

}
