resource "aws_subnet" "private-subnet-1" {
  vpc_id            = aws_vpc.EKS_VPC.id
  cidr_block        = var.Private_Subnets[0]
  availability_zone = var.Availability_Zones[0]

  tags = {
    "Name"                                      = "private-${var.Availability_Zones[0]}"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
    "kubernetes.io/role/internal-elb"           = "1"
  }
}

resource "aws_subnet" "private-subnet-2" {
  vpc_id            = aws_vpc.EKS_VPC.id
  cidr_block        = var.Private_Subnets[1]
  availability_zone = var.Availability_Zones[1]

  tags = {
    "Name"                                      = "private-${var.Availability_Zones[1]}"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
    "kubernetes.io/role/internal-elb"           = "1"
  }
}

resource "aws_subnet" "public-subnet-1" {
  vpc_id                  = aws_vpc.EKS_VPC.id
  cidr_block              = var.Public_Subnets[0]
  availability_zone       = var.Availability_Zones[0]
  map_public_ip_on_launch = true

  tags = {
    "Name"                                      = "public-${var.Availability_Zones[0]}"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
    "kubernetes.io/role/elb"                    = "1"
  }
}

resource "aws_subnet" "public-subnet-2" {
  vpc_id                  = aws_vpc.EKS_VPC.id
  cidr_block              = var.Public_Subnets[1]
  availability_zone       = var.Availability_Zones[1]
  map_public_ip_on_launch = true

  tags = {
    "Name"                                      = "public-${var.Availability_Zones[1]}"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
    "kubernetes.io/role/elb"                    = "1"
  }
}