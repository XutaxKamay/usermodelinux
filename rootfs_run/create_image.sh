./umount.sh
dd if=/dev/zero of=rootfs-image count=0 obs=1MB seek=2000
sudo mkfs.ext4 rootfs-image
./mount.sh
cd /uml_rootfs
sudo wget -N -q -O /tmp/directory.html 'http://mir.archlinux.fr/iso/latest/'
archlinuxbootstrap=$(sudo cat /tmp/directory.html| \
    grep bootstrap|grep -F 'tar.gz</a>'|awk -F'>' '{print $2}'|rev|cut -c 4-|rev)
sudo wget -O /var/archlinux-rfs-x86_64.tar.gz http://mir.archlinux.fr/iso/latest/$archlinuxbootstrap
sudo tar xf /var/archlinux-rfs-x86_64.tar.gz -C /uml_rootfs
sudo mv /uml_rootfs/root.x86_64/* /uml_rootfs
sudo rm /uml_rootfs/root.x86_64 -r
./populate.sh
