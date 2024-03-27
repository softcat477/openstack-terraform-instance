# Boot from an image
resource "openstack_compute_instance_v2" "boot-from-image" {
    name = "boot-from-image"
    image_id = var.image-id
    flavor_name = var.flavor
    key_pair = var.keypair
    security_groups = var.sg

    network {
        name = var.network-name
    }
}

output "boot-from-image" {
  value = openstack_compute_instance_v2.boot-from-image.access_ip_v4
}  