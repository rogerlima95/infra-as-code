locals {
  project_id   = "desafio-434619"
  region       = "us-central1"
}

inputs = {
  project_id   = local.project_id
  region       = local.region
}

remote_state {
  backend = "gcs"
  config = {
    bucket = "tfstate-bucket-1304"
    prefix = "${path_relative_to_include()}/state"
  }
}

generate "backend" {
  path      = "backend.tf"     
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  backend "gcs" {}
}
EOF
}