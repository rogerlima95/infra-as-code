resource "google_container_cluster" "autopilot" {
  name     = var.cluster_name
  location = var.region
  project  = var.project_id

  # Habilita o modo Autopilot
  enable_autopilot           = true

  # Rede pública
  network    = var.network
  subnetwork = "projects/${var.project_id}/regions/${var.region}/subnetworks/${var.subnetwork}"
  enable_l4_ilb_subsetting = var.enable_l4_ilb_subsetting
  deletion_protection = var.deletion_protection

  # Define o acesso ao master
  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = var.cidr_block
      display_name = "default"
    }
  }
}