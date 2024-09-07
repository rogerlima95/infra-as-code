include {
  path = find_in_parent_folders("project.hcl")
}

dependency "vpc_a" {
  config_path = "../../vpc/vpc-a/"
}


terraform {
  source = "../../../../modules/subnets"
}

inputs = {
    network_name = dependency.vpc_a.outputs.network_name
    subnets = [
        {
            subnet_name           = "subnet-1a"
            subnet_ip             = "10.10.11.0/24"
            subnet_region         = "us-central1"
        }
    ]
}