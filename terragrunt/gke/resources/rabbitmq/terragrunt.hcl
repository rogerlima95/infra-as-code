include {
  path = find_in_parent_folders("project.hcl")
}

dependency "cluster-b" {
  config_path = "../../clusters/cluster-b"
}


terraform {
  source = "../../../../modules/rabbitmq"
}


inputs = {
  cluster_name = "cluster-b"
}