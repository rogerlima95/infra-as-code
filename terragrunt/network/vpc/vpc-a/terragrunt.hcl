include {
  path = find_in_parent_folders("project.hcl")
}


terraform {
  source = "../../../../modules/vpc"
}

inputs = {
  network_name      = "vpc-a"
  routing_mode      = "GLOBAL"
  description       = "VPC A"
}