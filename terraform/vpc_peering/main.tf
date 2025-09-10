data "aws_vpc" "default_vpc" {
  default = true
}


resource "aws_vpc_peering_connection" "vpc_peering" {
  vpc_id        = data.aws_vpc.default_vpc.id              
  peer_vpc_id   = var.vpc_id        
  peer_region   = var.region_name         
  tags = {
    Name = "peering connection"
  }
}

resource "aws_vpc_peering_connection_accepter" "accepter" {
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id
  auto_accept               = true
}

data "aws_route_table" "default_RT" {
  vpc_id = data.aws_vpc.default_vpc.id
  filter {
    name = "association.main"
    values = [ "true" ]

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

data "aws_security_group" "default_sg" {
  vpc_id = data.aws_vpc.default_vpc.id
  filter {
    name = "group-name"
    values = [ "default" ]
  }
}
resource "aws_vpc_peering_connection" "main" {
  peer_vpc_id = var.peer_vpc_id      # pass as variable
  vpc_id      = var.vpc_id           # pass as variable
  auto_accept = true

  tags = {
    Name = "main-vpc-peering"
  }
}

