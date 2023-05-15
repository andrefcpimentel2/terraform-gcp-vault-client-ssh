resource "google_compute_network" "vpc" {
  project = var.project
  name                    = "${var.namespace}-vpc"

  routing_mode            = "GLOBAL"
}



resource "google_compute_firewall" "allow-ssh" {
  project = var.project
  name    = "${var.namespace}-fw-allow-ssh"
  network = google_compute_network.vpc.name
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["ssh"]
}

# # allow rdp
# resource "google_compute_firewall" "allow-rdp" {
#   name    = "${var.namespace}-fw-allow-rdp"
#   network = google_compute_network.vpc.name
#   allow {
#     protocol = "tcp"
#     ports    = ["3389"]
#   }

#   source_ranges = ["0.0.0.0/0"]
#   target_tags = ["rdp"]
# }