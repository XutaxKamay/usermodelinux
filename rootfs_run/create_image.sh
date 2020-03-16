dd if=/dev/zero of=rootfs-image count=0 obs=1MB seek=1000
sudo mkfs.ext4 rootfs-image
