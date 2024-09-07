variable "name" {
  description = "The name of the bucket."
  type        = string
}

variable "project_id" {
  description = "The ID of the project to create the bucket in."
  type        = string
}

variable "location" {
  description = "The location of the bucket."
  type        = string
}

variable "storage_class" {
  description = "The Storage Class of the new bucket."
  type        = string
  default     = null
}

variable "labels" {
  description = "A set of key/value label pairs to assign to the bucket."
  type        = map(string)
  default     = null
}


variable "bucket_policy_only" {
  description = "Enables Bucket Policy Only access to a bucket."
  type        = bool
  default     = true
}

variable "versioning" {
  description = "While set to true, versioning is fully enabled for this bucket."
  type        = bool
  default     = true
}

variable "autoclass" {
  description = "While set to true, autoclass is enabled for this bucket."
  type        = bool
  default     = false
}

variable "force_destroy" {
  description = "When deleting a bucket, this boolean option will delete all contained objects. If false, Terraform will fail to delete buckets which contain objects."
  type        = bool
  default     = false
}

variable "iam_members" {
  description = "The list of IAM members to grant permissions on the bucket."
  type = list(object({
    role   = string
    member = string
  }))
  default = []
}

variable "retention_policy" {
  description = "Configuration of the bucket's data retention policy for how long objects in the bucket should be retained."
  type = object({
    is_locked        = bool
    retention_period = number
  })
  default = null
}

variable "custom_placement_config" {
  description = "Configuration of the bucket's custom location in a dual-region bucket setup. If the bucket is designated a single or multi-region, the variable are null."
  type = object({
    data_locations = list(string)
  })
  default = null
}

variable "cors" {
  description = "Configuration of CORS for bucket with structure as defined in https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket#cors."
  type        = any
  default     = []
}

variable "encryption" {
  description = "A Cloud KMS key that will be used to encrypt objects inserted into this bucket. If default_kms_key_name is set to 'null' a new keyring and key pair will be created and used to encrypt bucket using CMEK."
  type = object({
    default_kms_key_name = string
  })
  default = null
}

variable "log_bucket" {
  description = "The bucket that will receive log objects."
  type        = string
  default     = null
}

variable "log_object_prefix" {
  description = "The object prefix for log objects. If it's not provided, by default GCS sets this to this bucket's name"
  type        = string
  default     = null
}

variable "website" {
  type        = map(any)
  default     = {}
  description = "Map of website values. Supported attributes: main_page_suffix, not_found_page"
}

variable "public_access_prevention" {
  description = "Prevents public access to a bucket. Acceptable values are inherited or enforced. If inherited, the bucket uses public access prevention, only if the bucket is subject to the public access prevention organization policy constraint."
  type        = string
  default     = "inherited"
}

variable "soft_delete_policy" {
  description = "Soft delete policies to apply. Format is the same as described in provider documentation https://www.terraform.io/docs/providers/google/r/storage_bucket.html#nested_soft_delete_policy"
  type = object({
    retention_duration_seconds = optional(number)
  })
  default = {}
}