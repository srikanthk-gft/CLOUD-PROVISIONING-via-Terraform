provider "oci" {
  tenancy_ocid     = "${var.tenancy_ocid}"
  user_ocid        = "${var.user_ocid}"
  fingerprint      = "${var.fingerprint}"
  private_key_path = "${var.private_key_path}"
  region           = "${var.region}"
}

  resource "oci_core_instance" "test-instance" {
	  count               = "${var.server_count}"
	  availability_domain = "${var.availability_domain}"
	  compartment_id      = "${var.tenancy_ocid}"
	  shape               = "${var.shape}"
	  display_name        = "${var.display_name}-${count.index}"
	  create_vnic_details {
	    subnet_id         = "${var.subnet_id}"
        display_name      = "primaryvnic"
        assign_public_ip  = true
      }
      source_details {
        source_id       = "${var.source_id}"
        source_type     = "image"
      }
  }
