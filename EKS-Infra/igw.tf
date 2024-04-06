resource "aws_internet_gateway" "Internet_Gateway" {
  vpc_id = aws_vpc.EKS_VPC.id

  tags = {
    Name = "${var.Internet_Gateway_Name}"
  }
}