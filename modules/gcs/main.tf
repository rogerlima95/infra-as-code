resource "google_storage_bucket" "bucket" {
  name                        = var.name
  project                     = var.project_id
  location                    = var.location
  storage_class               = var.storage_class
  uniform_bucket_level_access = var.bucket_policy_only
  labels                      = var.labels
  force_destroy               = var.force_destroy
  public_access_prevention    = var.public_access_prevention

  versioning {
    enabled = var.versioning
  }

  autoclass {
    enabled = var.autoclass
  }

  dynamic "retention_policy" {
    for_each = var.retention_policy == null ? [] : [var.retention_policy]
    content {
      is_locked        = var.retention_policy.is_locked
      retention_period = var.retention_policy.retention_period
    }
  }

  dynamic "encryption" {
    for_each = var.encryption == null ? [] : [var.encryption]
    content {
      default_kms_key_name = var.encryption.default_kms_key_name != null ? var.encryption.default_kms_key_name : module.encryption_key[0].keys[var.name]
    }
  }

  dynamic "website" {
    for_each = length(keys(var.website)) == 0 ? toset([]) : toset([var.website])
    content {
      main_page_suffix = lookup(website.value, "main_page_suffix", null)
      not_found_page   = lookup(website.value, "not_found_page", null)
    }
  }

  dynamic "cors" {
    for_each = var.cors == null ? [] : var.cors
    content {
      origin          = lookup(cors.value, "origin", null)
      method          = lookup(cors.value, "method", null)
      response_header = lookup(cors.value, "response_header", null)
      max_age_seconds = lookup(cors.value, "max_age_seconds", null)
    }
  }

  dynamic "custom_placement_config" {
    for_each = var.custom_placement_config == null ? [] : [var.custom_placement_config]
    content {
      data_locations = var.custom_placement_config.data_locations
    }
  }

  dynamic "logging" {
    for_each = var.log_bucket == null ? [] : [var.log_bucket]
    content {
      log_bucket        = var.log_bucket
      log_object_prefix = var.log_object_prefix
    }
  }

  dynamic "soft_delete_policy" {
    for_each = var.soft_delete_policy == {} ? [] : [var.soft_delete_policy]
    content {
      retention_duration_seconds = lookup(soft_delete_policy.value, "retention_duration_seconds", null)
    }
  }
}

resource "google_storage_bucket_iam_member" "members" {
  for_each = {
    for m in var.iam_members : "${m.role} ${m.member}" => m
  }
  bucket = google_storage_bucket.bucket.name
  role   = each.value.role
  member = each.value.member
}

data "google_storage_project_service_account" "gcs_account" {
  project = var.project_id
}

module "encryption_key" {
  count              = var.encryption == null ? 0 : (var.encryption.default_kms_key_name == null ? 1 : 0)
  source             = "terraform-google-modules/kms/google"
  version            = "~> 2.0"
  project_id         = var.project_id
  location           = var.location
  keyring            = var.name
  prevent_destroy    = false
  keys               = [var.name]
  set_decrypters_for = [var.name]
  set_encrypters_for = [var.name]
  decrypters         = ["serviceAccount:${data.google_storage_project_service_account.gcs_account.email_address}"]
  encrypters         = ["serviceAccount:${data.google_storage_project_service_account.gcs_account.email_address}"]
}