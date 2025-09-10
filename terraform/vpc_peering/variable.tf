variable "peer_vpc_id" {
  description = "The ID of the peer VPC"
  type        = string
}

variable "region_name" {
  description = "The region of the peer VPC"
  type        = string
}

variable "peer_cidr" {
  description = "The CIDR block of the peer VPC"
  type        = string
}
