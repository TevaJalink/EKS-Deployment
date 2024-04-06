resource "aws_eip" "nat_public_ip" {
  domain = "vpc"

  tags = {
    Name = "${var.Nat_Gateway_Name}"
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_public_ip.id
  subnet_id     = aws_subnet.public-subnet-1.id

  tags = {
    Name = "nat_eip"
  }

  depends_on = [aws_internet_gateway.Internet_Gateway]
}