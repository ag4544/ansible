provider "hcloud" {
  token = var.hcloud_token
}

data "hcloud_ssh_key" "rebrain" {
  name = "REBRAIN.SSH.PUB.KEY"
}

resource "hcloud_ssh_key" "default" {
  name       = "ag4544_ansible_key"
  public_key = file("~/.ssh/ansible_tasks.pub")
}


resource "hcloud_server" "load_balancer" {
  image       = "debian-10"
  name        = "ag4544-lb"
  location    = "hel1"
  server_type = "cx11"
  ssh_keys = [
    data.hcloud_ssh_key.rebrain.id,
    hcloud_ssh_key.default.id
  ]
  labels = {
    module = "devops"
    email  = "ag4544_at_yandex_ru"
  }
}

resource "hcloud_server" "application" {
  image       = "debian-10"
  name        = "ag4544-app"
  location    = "hel1"
  server_type = "cx11"
  ssh_keys = [
    data.hcloud_ssh_key.rebrain.id,
    hcloud_ssh_key.default.id
  ]
  labels = {
    module = "devops"
    email  = "ag4544_at_yandex_ru"
  }
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
  name    = "${hcloud_server.load_balancer.name}.${data.aws_route53_zone.rebrain.name}"
  type    = "A"
  ttl     = "300"
  records = [hcloud_server.load_balancer.ipv4_address]
}

resource "aws_route53_record" "app" {
  zone_id = data.aws_route53_zone.rebrain.zone_id
  name    = "${hcloud_server.application.name}.${data.aws_route53_zone.rebrain.name}"
  type    = "A"
  ttl     = "300"
  records = [hcloud_server.application.ipv4_address]
}

output "VPS_summary" {
  value = [aws_route53_record.lb.name, aws_route53_record.app.name]
}

resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/hostinventory.tpl", {
    server_name_lb = aws_route53_record.lb.name,
  server_name_app = aws_route53_record.app.name })
  filename = "../ansible/hosts.yml"
}

resource "null_resource" "ansible_playbook" {
  provisioner "local-exec" {
    command = "sleep 20 && ansible-playbook -i ../ansible/hosts.yml ../ansible/task12.yml"
  }
  depends_on = [local_file.ansible_inventory]
}
