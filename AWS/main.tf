provider "aws" {
  region = var.aws_region
}

resource "aws_elb" "gft" {
  name = "gft-tf-aws-elb"

  # Availability zone of instances to be created in 
  availability_zones = aws_instance.gft.*.availability_zone
  
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  # The instances are registered automatically
  instances = aws_instance.gft.*.id
}

resource "aws_instance" "gft" {
  instance_type = "m1.small"
  ami = var.ami_name
  # Number of instances to be created
  count = var.inst_count
}

resource "aws_ebs_volume" "ebs_vol" {
  count = var.inst_count
  availability_zone = element(aws_instance.gft.*.availability_zone, count.index)
  size              = 50
}

resource "aws_volume_attachment" "ebs_attach" {
  count       = var.inst_count
  volume_id   = aws_ebs_volume.ebs_vol.*.id[count.index]
  device_name = element(var.ebs_names, count.index)
  instance_id = element(aws_instance.gft.*.id, count.index)
}