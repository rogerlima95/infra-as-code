dependency "vpc_a" {
  config_path = "../vpc/vpc-a/"
}

dependency "vpc_b" {
  config_path = "../vpc/vpc-b/"
}

dependency "subnet_a" {
  config_path = "../subnets/subnet-1a/"
}

dependency "subnet_b" {
  config_path = "../subnets/subnet-1b/"
}

terraform {
  source = "../../../modules/network_peering"
}

inputs = {
  prefix                                   = "peering"
  local_network                            = dependency.vpc_a.outputs.network_self_link
  peer_network                             = dependency.vpc_b.outputs.network_self_link
  export_local_custom_routes               = true
  export_peer_custom_routes                = true
  export_peer_subnet_routes_with_public_ip = true

}