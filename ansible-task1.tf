provider "hcloud" {
  token = var.hcloud_token
}

data "hcloud_ssh_key" "rebrain" {
  name = "REBRAIN.SSH.PUB.KEY"
}

resource "hcloud_ssh_key" "default" {
  name       = "TF_key2"
  public_key = file("/home/ag4544/.ssh/tf_rsa.pub")
}

resource "hcloud_server" "ansible_task1" {
  image       = "debian-10"
  name        = "ansible-task1"
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

output "VPS_summary" {
  value = hcloud_server.ansible_task1.ipv4_address
}

resource "local_file" "inventory" {
  content = templatefile("${path.module}/inventory.tpl", {
    server_ip = hcloud_server.ansible_task1.ipv4_address
  })
  filename = "${path.module}/ansible/hosts.txt"
}
