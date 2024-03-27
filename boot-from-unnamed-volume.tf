# Create an instance boot from volume: Create a bootable volume from an image and boot an instance from the volume.
# 1. The volume will not be destroyed once the resource is terminated
# 2. You cannot specify the volume name. It will be a messy random name generated from openstack

resource "openstack_compute_instance_v2" "boot-from-unnamed-volume" {
  name            = "boot-from-unnamed-volume"
  flavor_name       = var.flavor
  key_pair        = var.keypair
  security_groups = var.sg

  block_device {
    uuid                  = var.image-id
    source_type           = "image"
    volume_size           = 20
    boot_index            = 0
    destination_type      = "volume"
    delete_on_termination = false
  }

  network {
    name = var.network-name
  }
}

output "boot-from-unnamed-volume" {
  value = openstack_compute_instance_v2.boot-from-unnamed-volume.access_ip_v4
}