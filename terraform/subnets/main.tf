# public subnet
resource "aws_subnet" "pub-sub" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.pub-cidr
  availability_zone       = var.pub-sub-az

  tags = {
    Name = "public-subnet"
  }
}

# private subnet
resource "aws_subnet" "pri-sub-1" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.pri-sub-1-cidr
  availability_zone       = var.pri-sub1-az

  tags = {
    Name = "private-subnet-1"
  }
}

resource "aws_subnet" "pri-sub-2" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.pri-sub-2-cidr
  availability_zone       = var.pri-sub2-az

  tags = {
    Name = "private-subnet-2"
  }
}

resource "aws_subnet" "pri-sub-3" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.pri-sub-3-cidr
  availability_zone       = var.pri-sub3-az

  tags = {
    Name = "private-subnet-3"
  }
}


# Elastic IP
resource "aws_eip" "nat" {
  domain = "vpc"
}

# Nat gatway
resource "aws_nat_gateway" "Nat-gate" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.pub-sub.id

  tags = {
    Name = "Nat-gate"
  }
}
resource "aws_route" "default_rt" {
  route_table_id         = "rtb-0078f850542a62a00"
  destination_cidr_block = "10.0.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.main.id

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [destination_cidr_block]
  }
}

