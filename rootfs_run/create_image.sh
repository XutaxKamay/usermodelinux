./umount.sh
dd if=/dev/zero of=rootfs-image count=0 obs=1MB seek=2000
sudo mkfs.ext4 rootfs-image -F
./mount.sh
echo 'Finding version for root filesystem'
sudo wget -q -O /tmp/directory.html 'http://mir.archlinux.fr/iso/latest/'
archlinuxbootstrap=$(sudo cat /tmp/directory.html| \
    grep bootstrap|grep -F 'tar.gz</a>'|awk -F'>' '{print $2}'|rev|cut -c 4-|rev)
echo 'Downloading/Updating archlinux bootstrap'
sudo wget -q -N -c -O /var/archlinux-rfs-x86_64.tar.gz http://mir.archlinux.fr/iso/latest/$archlinuxbootstrap
echo 'Extracting...'
sudo tar -xf /var/archlinux-rfs-x86_64.tar.gz -C /uml_rootfs
echo 'Moving folders...'
sudo mv /uml_rootfs/root.x86_64/* /uml_rootfs
sudo rm /uml_rootfs/root.x86_64 -r
echo 'Populating'
./populate.sh
./umount.sh
echo -e '\e[33mDone creating image!'
notify-send 'Done creating image!'
