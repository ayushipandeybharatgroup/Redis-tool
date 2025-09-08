# Create VPC Peering Connection
resource "aws_vpc_peering_connection" "main" {
  vpc_id        = var.vpc_id_1
  peer_vpc_id   = var.vpc_id_2
  auto_accept   = true

  tags = {
    Name = "my-vpc-peering"
  }
}

# Add route for VPC1 -> VPC2
resource "aws_route" "vpc1-to-vpc2" {
  route_table_id            = var.rt_id_vpc1
  destination_cidr_block    = var.vpc2_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.main.id
}

# Add route for VPC2 -> VPC1
resource "aws_route" "vpc2-to-vpc1" {
  route_table_id            = var.rt_id_vpc2
  destination_cidr_block    = var.vpc1_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.main.id
}
