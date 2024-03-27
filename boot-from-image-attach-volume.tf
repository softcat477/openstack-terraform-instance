# Boot from an image and create and attach a volume
resource "openstack_blockstorage_volume_v3" "boot-from-image-volume" {
  name = "boot-from-image-attached-volume"
  size = 1
}

# ======
# Comment out this section to terminate the instance without deleting the volumes
resource "openstack_compute_volume_attach_v2" "boot-from-image-attach-point" {
  instance_id = openstack_compute_instance_v2.boot-from-image-attach-volume.id
  volume_id   = openstack_blockstorage_volume_v3.boot-from-image-volume.id
}

resource "openstack_compute_instance_v2" "boot-from-image-attach-volume" {
    name = "boot-from-image-attach-volume"
    image_id = var.image-id
    flavor_name = var.flavor
    key_pair = var.keypair
    security_groups = var.sg

    network {
        name = var.network-name
    }
}

output "boot-from-image-attach-volume" {
  value = openstack_compute_instance_v2.boot-from-image-attach-volume.access_ip_v4
} 
# ======