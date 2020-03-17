./mount.sh
sudo /uml_rootfs/bin/arch-chroot \
/uml_rootfs /bin/bash -c '
pacman-key --init;
pacman-key --populate archlinux;
echo "Server = https://mirror.oldsql.cc/archlinux/\$repo/os/\$arch" > /etc/pacman.d/mirrorlist;
pacman -Syyu --noconfirm;
pacman -S base base-devel vim iproute2 --noconfirm;
echo "Creating udb0";
mknod --mode=777 /dev/ubd0 b 98 0;
chown root:disk /dev/ubd0;
exit'

cat init.sh | sudo tee /uml_rootfs/init.sh
sudo chmod 777 /uml_rootfs/init.sh
echo '/dev/ubd0 / ext4 defaults 0 0' | sudo tee /uml_rootfs/etc/fstab
./umount.sh
