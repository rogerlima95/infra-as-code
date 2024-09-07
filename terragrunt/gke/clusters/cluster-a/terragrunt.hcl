include {
  path = find_in_parent_folders("project.hcl")
}

dependency "vpc_a" {
  config_path = "../../../network/vpc/vpc-a/"
}

dependency "subnet_a" {
  config_path = "../../../network/subnets/subnet-1a/"
}

dependency "peering" {
  config_path = "../../../network/network_peering/"
}

terraform {
  source = "../../../../modules/gke"
}

inputs = {
  cluster_name = "cluster-a"
  network                            = dependency.vpc_a.outputs.network_id
  subnetwork                         = "subnet-1a"

}