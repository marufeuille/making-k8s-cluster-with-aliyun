variable "access_key" {}
variable "secret_key" {}
variable "region" {}
variable "zone" {}

provider "alicloud" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region = "${var.region}"
}

resource "alicloud_key_pair" "publickey" {
    key_name = "terraform-publickey"
    public_key = "${file("./keys/id_rsa.pub")}"
}

resource "alicloud_vpc" "vpc" {
  name = "terraform-vpc"
  cidr_block = "192.168.1.0/24"
}

resource "alicloud_vswitch" "vsw" {
  vpc_id            = "${alicloud_vpc.vpc.id}"
  cidr_block        = "192.168.1.0/28"
  availability_zone = "${var.zone}"
}

resource "alicloud_cs_kubernetes" "main" {
  name_prefix = "terraform-k8s"
  availability_zone = "${alicloud_vswitch.vsw.availability_zone}"
  new_nat_gateway = true
  master_instance_types = ["ecs.n4.small"]
  worker_instance_types = ["ecs.n4.small"]
  worker_numbers = [1]
  key_name = "${alicloud_key_pair.publickey.key_name}"
  pod_cidr = "172.16.1.0/24"
  service_cidr = "172.16.2.0/24"
  enable_ssh = true
  kube_config = "/root/.kube/config"
  log_config = {
    type = "SLS"
    project = "my-log00"
  }
}
