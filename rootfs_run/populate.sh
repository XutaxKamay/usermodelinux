sudo /uml_rootfs/bin/arch-chroot \
/uml_rootfs /bin/bash -c '
pacman-key --init;
pacman-key --populate archlinux;
echo "Server = https://mirror.rackspace.com/archlinux/$repo/os/$arch" > /etc/pacman.d/mirrorlist;
pacman -Syyu --noconfirm;
pacman -S base --noconfirm;
exit'

sudo $(cat init.sh) > /uml_rootfs/init.sh
sudo chmod 770 /uml_rootfs/init.sh
