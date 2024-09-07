include {
  path = find_in_parent_folders("project.hcl")
}

dependency "vpc_b" {
  config_path = "../../vpc/vpc-b/"
}


terraform {
  source = "../../../../modules/subnets"
}

inputs = {
    network_name = dependency.vpc_b.outputs.network_name
    subnets = [
        {
            subnet_name           = "subnet-1b"
            subnet_ip             = "10.10.10.0/24"
            subnet_region         = "us-central1"
        }
    ]
}