include {
  path = find_in_parent_folders("project.hcl")
}

dependency "cluster-a" {
  config_path = "../../clusters/cluster-a"
}


terraform {
  source = "../../../../modules/nginx"
}


inputs = {
  service_name = "app-service-a"
  cluster_name = "cluster-a"
}