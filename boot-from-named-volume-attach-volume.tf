# Boot Instance from a named volume. Create and attach a volume to it.
# 1. Create and name a bootable volume from an image -> "boot-from-named-volume-bootable-volume"
# 2. Create and name volume -> "boot-from-named-volume-attached-volume"
# 3. Boot an instance from the bootable volume -> "boot-from-named-volume"
# 4. Attach the volume to it -> boot-from-named-volume-attach-point

# 1
resource "openstack_blockstorage_volume_v3" "boot-from-named-volume-bootable-volume" {
  name     = "boot-from-named-volume-bootable-volume"
  size     = 20
  image_id = var.image-id
}

# 2
resource "openstack_blockstorage_volume_v3" "boot-from-named-volume-attached-volume" {
  name = "boot-from-named-volume-attached-volume"
  size = 10
}

# ======
# Comment out this section to terminate the instance without deleting the volumes (both bootable and attached)
# 4
resource "openstack_compute_volume_attach_v2" "boot-from-named-volume-attach-point" {
  instance_id = openstack_compute_instance_v2.boot-from-named-volume.id
  volume_id   = openstack_blockstorage_volume_v3.boot-from-named-volume-attached-volume.id
}

# 3
resource "openstack_compute_instance_v2" "boot-from-named-volume" {
  name            = "boot-from-named-volume"
  flavor_name       = var.flavor
  key_pair        = var.keypair
  security_groups = var.sg

  block_device {
    uuid                  = openstack_blockstorage_volume_v3.boot-from-named-volume-bootable-volume.id
    source_type           = "volume"
    destination_type      = "volume"
    volume_size           = 20
    boot_index            = 0
    delete_on_termination = false
  }

  network {
    name = var.network-name
  }
}

output "boot-from-named-volume" {
  value = openstack_compute_instance_v2.boot-from-named-volume.access_ip_v4
}
# ======