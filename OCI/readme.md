Note that on OCI we are limited with 2 public IPs. So if we are deploying instances with public IPs server count should be a max of 2.

And also, to deploy run the following with appropriate values in variables below.

terraform plan -var tenancy_ocid=" " -var user_ocid=" " -var fingerprint=" " -var private_key_path=" " -var server_count=2

terraform apply -var tenancy_ocid=" " -var user_ocid=" " -var fingerprint=" " -var private_key_path=" " -var server_count=2
