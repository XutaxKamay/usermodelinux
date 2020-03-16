sudo /uml_rootfs/bin/arch-chroot \
/uml_rootfs /bin/bash -c '
pacman-key --init;
pacman-key --populate archlinux;
echo "Server = https://mirror.oldsql.cc/archlinux/\$repo/os/\$arch" > /etc/pacman.d/mirrorlist;
pacman -Syyu --noconfirm;
pacman -S base base-devel vim iproute2 --noconfirm;
exit'

cat init.sh | sudo tee /uml_rootfs/init.sh
sudo chmod 770 /uml_rootfs/init.sh
echo '/dev/ubd0 / ext2 defaults 0 0' | sudo tee /uml_rootfs/etc/fstab
