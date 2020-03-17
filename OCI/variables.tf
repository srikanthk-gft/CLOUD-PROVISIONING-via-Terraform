variable "tenancy_ocid" {
  description = "Tenancy OCID."
  default     = ""
}

variable "user_ocid" {
  description = "USER OCID"
  default     = ""
}

variable "fingerprint" {
  description = "FIngerprint"
  default     = ""
}

variable "private_key_path" {
  description = "Private key path"
  default     = ""
}

variable "region" {
  description = "The name of the region"
  default     = "us-phoenix-1"
}

variable "shape" {
  description = "Size of the VM"
  default     = "VM.Standard.E2.1.Micro"
}

variable "subnet_id" {
  description = "Public Subnet DEMO"
  default     = "ocid1.subnet.oc1.phx.aaaaaaaauqooyf4slwgq2dqufoiigvzoba2oudrtwrwxwa5d5kmbec2wqela"
}

variable "display_name" {
  description = "Hostname"
  default     = "gftocivmpip"
}

variable "availability_domain" {
  description = "Domain ID"
  default     = "tvyk:PHX-AD-2"
}

variable "source_id" {
  description = "Image ID"
  default     = "ocid1.image.oc1.phx.aaaaaaaak3hatlw7tncpvvatc4t7ihocxfx243ii54m2kuxjlsln4vnspnea"
}

variable "server_count" {
  description = "Number of Instances"
  default     = 2
}
