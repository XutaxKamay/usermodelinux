LIGHTGREEN='\033[1;32m'
./umount.sh
dd if=/dev/zero of=rootfs-image count=0 obs=1MB seek=8000
sudo mkfs.ext4 rootfs-image -F
./mount.sh
echo 'Finding version for root filesystem'
wget -q -O /tmp/directory.html 'http://mir.archlinux.fr/iso/latest/'
archlinuxbootstrap=$(cat /tmp/directory.html| \
    grep bootstrap|grep -F 'tar.gz</a>'|awk -F'>' '{print $2}'|rev|cut -c 4-|rev)
echo 'Downloading/Updating archlinux bootstrap'
wget -q -N -c -O /var/archlinux-rfs-x86_64.tar.gz http://mir.archlinux.fr/iso/latest/$archlinuxbootstrap
echo 'Extracting...'
sudo mkdir -p /uml_rootfs
sudo chown $USER:$USER /uml_rootfs -R
sudo tar -xf /var/archlinux-rfs-x86_64.tar.gz -C /uml_rootfs
echo 'Moving folders...'
sudo mv /uml_rootfs/root.x86_64/* /uml_rootfs
sudo rm /uml_rootfs/root.x86_64 -r
echo 'Populating'
./populate.sh
./umount.sh
echo "${LIGHTGREEN}Done creating image!"
notify-send 'Done creating image!'
