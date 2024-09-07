include {
  path = find_in_parent_folders("project.hcl")
}


terraform {
  source = "../../modules/gcs"
}

inputs = {
  name       = "bucket-app-203-b"
  location   = "US"
  versioning = false
  iam_members = [{
    role   = "roles/storage.objectViewer"
    member = "allUsers"
  }]
}
