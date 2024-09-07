provider "google" {
  project = var.project_id
  region  = var.region
}

provider "kubernetes" {
  host                   = "https://${data.google_container_cluster.gke.endpoint}"
  cluster_ca_certificate = base64decode(data.google_container_cluster.gke.master_auth[0].cluster_ca_certificate)
  token                  = data.google_client_config.default.access_token
}

provider "helm" {
  kubernetes {
    host                   = "https://${data.google_container_cluster.gke.endpoint}"
    cluster_ca_certificate = base64decode(data.google_container_cluster.gke.master_auth[0].cluster_ca_certificate)
    token                  = data.google_client_config.default.access_token
  }
}

data "google_client_config" "default" {}

data "google_container_cluster" "gke" {
  name     = var.cluster_name
  location = var.region
  project  = var.project_id
}

resource "helm_release" "helm_rabbitmq" {
  name       = "rabbitmq"
  chart      = "rabbitmq"
  repository = "https://charts.bitnami.com/bitnami"
  version    = "10.2.1"

  set {
    name  = "service.type"
    value = "LoadBalancer"
  }

  set {
    name  = "service.annotations.cloud\\.google\\.com/load-balancer-type"
    value = "Internal"
  }

  depends_on = [data.google_container_cluster.gke]
}