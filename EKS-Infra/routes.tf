resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.EKS_VPC.id

  tags = {
    Name = "private_route_table"
  }
}

resource "aws_route" "private_route_table" {
  route_table_id         = aws_route_table.private_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway.id
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.EKS_VPC.id

  tags = {
    Name = "public_route_table"
  }
}

resource "aws_route" "public-route-routing-table" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.Internet_Gateway.id
  depends_on             = [aws_route_table.public_route_table]
}

resource "aws_route_table_association" "private-subnet-1" {
  subnet_id      = aws_subnet.private-subnet-1.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private-subnet-2" {
  subnet_id      = aws_subnet.private-subnet-2.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "public-subnet-1" {
  subnet_id      = aws_subnet.public-subnet-1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public-subnet-2" {
  subnet_id      = aws_subnet.public-subnet-2.id
  route_table_id = aws_route_table.public_route_table.id
}