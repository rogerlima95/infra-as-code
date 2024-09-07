include {
  path = find_in_parent_folders("project.hcl")
}

dependency "vpc_b" {
  config_path = "../../../network/vpc/vpc-b/"
}

dependency "subnet_b" {
  config_path = "../../../network/subnets/subnet-1b/"
}

dependency "peering" {
  config_path = "../../../network/network_peering/"
}

terraform {
  source = "../../../../modules/gke"
}

inputs = {
  cluster_name = "cluster-b"
  network                            = dependency.vpc_b.outputs.network_id
  subnetwork                         = "subnet-1b"

}