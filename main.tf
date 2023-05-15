resource "random_id" "instance_id" {
  byte_length = 4
}

data "template_file" "linux-metadata" {
template = <<EOF
sudo apt-get update && sudo apt-get -y install gpg; 
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg;
gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint;
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list;
sudo apt update;
sudo apt-get install -y vault;
EOF
}

resource "google_compute_instance" "vm_instance_public" {
  project = var.project
  zone = "${var.gcp_region}-a"
  name         = "${var.namespace}-vm"
  machine_type = var.linux_instance_type
  tags         = ["ssh","http"]

  metadata = {
    sshKeys = "${var.ssh_user}:${var.ssh_pub_key_file}"
  }

  boot_disk {
    initialize_params {
      image = var.sku
    }
  }

  metadata_startup_script = data.template_file.linux-metadata.rendered

  network_interface {
    network       = google_compute_network.vpc.name
    access_config { }
  }
} 