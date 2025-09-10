variable "peer_vpc_id" {
  description = "ID of the peer VPC"
  type        = string
}

variable "region_name" {
  description = "Region of the peer VPC"
  type        = string
}

variable "peer_cidr" {
  description = "CIDR block of the peer VPC"
  type        = string
}
