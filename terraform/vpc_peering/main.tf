data "aws_vpc" "default_vpc" {
  default = true
}

# Create VPC peering connection
resource "aws_vpc_peering_connection" "main" {
  vpc_id      = data.aws_vpc.default_vpc.id   # local VPC
  peer_vpc_id = var.peer_vpc_id               # target VPC (from variable)
  peer_region = var.region_name

  tags = {
    Name = "main-vpc-peering"
  }
}

# Accept the peering connection
resource "aws_vpc_peering_connection_accepter" "accepter" {
  vpc_peering_connection_id = aws_vpc_peering_connection.main.id
  auto_accept               = true
}

# Get the default route table of the default VPC
data "aws_route_table" "default_RT" {
  vpc_id = data.aws_vpc.default_vpc.id
  filter {
    name   = "association.main"
    values = ["true"]
  }
}

# Create a route through the peering connection
resource "aws_route" "default_rt" {
  route_table_id            = data.aws_route_table.default_RT.id
  destination_cidr_block    = var.peer_cidr   # pass as variable
  vpc_peering_connection_id = aws_vpc_peering_connection.main.id

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [destination_cidr_block]
  }
}

# Fetch default security group (if needed)
data "aws_security_group" "default_sg" {
  vpc_id = data.aws_vpc.default_vpc.id
  filter {
    name   = "group-name"
    values = ["default"]
  }
}
