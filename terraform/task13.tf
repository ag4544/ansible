provider "google" {
  credentials = file("account.json")
  project     = "rebrain"
  region      = "europe-north1"
  zone        = "europe-north1-a"
}

resource "google_compute_global_forwarding_rule" "task13" {
  name       = "task13-load-balancer"
  target     = google_compute_target_http_proxy.task13.self_link
  ip_address = google_compute_global_address.task13.address
  port_range = "80"
  depends_on = [google_compute_global_address.task13]
}

resource "google_compute_target_http_proxy" "task13" {
  name    = "task13-proxy"
  url_map = google_compute_url_map.task13.self_link
}

resource "google_compute_url_map" "task13" {
  name        = "task13-url-map"
  description = "Send traffic to backend"

  default_service = google_compute_backend_service.task13.self_link
}

resource "google_compute_global_address" "task13" {
  name = "ag4544-task13-global-address"
}

resource "google_compute_backend_service" "task13" {
  name             = "ag4544-task13-backend"
  description      = "Backend for task 13"
  protocol         = "HTTP"
  port_name        = "task13"
  timeout_sec      = 10
  session_affinity = "NONE"
  health_checks    = [google_compute_http_health_check.task13.self_link]

  backend {
    group = google_compute_instance_group.task13.self_link
  }
}

resource "google_compute_firewall" "task13" {
  name    = "task13-firewall"
  network = "default"

  description = "allow Google health checks and network load balancers access"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443"]
  }
}

resource "google_compute_instance_template" "task13" {
  description = "Backend for task 13"

  tags = ["ag4544-at-yandex-ru", "devops"]

  instance_description = "Instance backend for task 13"
  machine_type         = "f1-micro"
  can_ip_forward       = false

  scheduling {
    automatic_restart   = false
    on_host_maintenance = "TERMINATE"
    preemptible         = false
  }

  disk {
    source_image = "debian-cloud/debian-10"
    auto_delete  = true
    boot         = true
  }

  network_interface {
    network = "default"

    access_config {
    }
  }

  metadata = {
    ssh-keys = "root:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDS8cvfCzwM0eATZUrP2UEz7UUluNg1w7hR042AZTpfj+bX0wv4oy673sPHX2nkLdxzHIX9rLPcDrg3AslkjbAs+VLStHgaQ72aa6SM9UTJlmo1mj/bNIWDd/MQdsZSjULVZKIBfMLJl4YQ924UHaw3KFMdTCew9FKVBjLm1eq3rKAJ4hPQGu3gu+B0UDgAj708QjZ4ghMD1xkSXX4kLC0yZL/UorU+jKCAEDqZ/dbkDMOUbJ/8RAy8FNfHfXUQ5W63eQ3E7n3ByYmcmDm0gRFot9pbywEp9wz4i1EyuViPQxvx5siFPzVsfFiJ7PMC6hFkh0pX3UvZwgBsmPHloNON"
  }

}

resource "google_compute_instance_from_template" "task13" {
  name = "ag4544-task13-instance"

  source_instance_template = google_compute_instance_template.task13.self_link

  can_ip_forward = false
  labels = {
    module = "devops"
    email  = "ag4544-at-yandex-ru"
  }
}

resource "google_compute_instance_group" "task13" {
  name = "ag4544-task13-instance-group"
  zone = "europe-north1-a"
  instances = [
    google_compute_instance_from_template.task13.self_link
  ]
  named_port {
    name = "task13"
    port = 80
  }
}

resource "google_compute_http_health_check" "task13" {
  name         = "ag4544-task13-health-check"
  request_path = "/health"

  timeout_sec        = 5
  check_interval_sec = 5
  port               = 80
}

output "ip-address-global" {
  value = google_compute_global_address.task13.address
}

output "ip-address-vps" {
  value = google_compute_instance_from_template.task13.network_interface.0.access_config.0.nat_ip
}

provider "aws" {
  region     = "eu-north-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

data "aws_route53_zone" "rebrain" {
  name         = "devops.rebrain.srwx.net."
  private_zone = false
}

resource "aws_route53_record" "lb" {
  zone_id = data.aws_route53_zone.rebrain.zone_id
  name    = "ag4544lb.${data.aws_route53_zone.rebrain.name}"
  type    = "A"
  ttl     = "300"
  records = [google_compute_global_address.task13.address]
}

output "VPS_summary" {
  value = aws_route53_record.lb.name
}


resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/hostinventory.tpl", {
    ip_gcp_vps = google_compute_instance_from_template.task13.network_interface.0.access_config.0.nat_ip})
  filename = "../ansible/hosts.txt"
}

resource "null_resource" "ansible_playbook" {
  provisioner "local-exec" {
    command = "sleep 20 && ansible-playbook -i ../ansible/hosts.txt ../ansible/task13.yml"
  }
  depends_on = [local_file.ansible_inventory, google_compute_global_forwarding_rule.task13]
}
