resource "aws_vpc" "matomo-vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "pub-subnet" {
  vpc_id     = aws_vpc.matomo-vpc.id
  cidr_block = element(var.cidr-pub, count.index)
  availability_zone = element(var.az, count.index)
  count = 2
}
resource "aws_subnet" "pri-subnet" {
  vpc_id     = aws_vpc.matomo-vpc.id
  cidr_block = element(var.cidr-pri, count.index)
  availability_zone = element(var.az, count.index)
  count = 2
}
resource "aws_internet_gateway" "matomo-igw" {
  vpc_id = aws_vpc.matomo-vpc.id
}

# Create an Amazon Elastic IP (EIP)
resource "aws_eip" "ngw-eip" {
  vpc = true
}

# Create a NAT Gateway
resource "aws_nat_gateway" "matomo-ngw" {
  allocation_id = aws_eip.ngw-eip.id
  subnet_id     = aws_subnet.pub-subnet[0].id
}

#create public route table
resource "aws_route_table" "pub-route" {
  vpc_id = aws_vpc.matomo-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.matomo-igw.id
  }
}

#create private route table
resource "aws_route_table" "pri-route" {
  vpc_id = aws_vpc.matomo-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.matomo-ngw.id
  }
}
#creating subnet association
resource "aws_route_table_association" "rtb-pub" {
  subnet_id      = aws_subnet.pub-subnet[0].id
  route_table_id = aws_route_table.pub-route.id
}
resource "aws_route_table_association" "rtb-pri" {
  subnet_id      = aws_subnet.pri-subnet[0].id
  route_table_id = aws_route_table.pri-route.id
}

