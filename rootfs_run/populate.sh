./mount.sh
sudo /uml_rootfs/bin/arch-chroot \
/uml_rootfs /bin/bash -c '
pacman-key --init;
pacman-key --populate archlinux;
echo "Server = https://mirror.oldsql.cc/archlinux/\$repo/os/\$arch" > /etc/pacman.d/mirrorlist;
pacman -Syyu base base-devel iproute2 vim --noconfirm;
echo "Creating udb0";
mknod --mode=777 /dev/ubd0 b 98 0;
chown root:disk /dev/ubd0;
echo "root:tlxkjc" | chpasswd;
exit'

cat init.sh | sudo tee /uml_rootfs/init.sh
sudo chmod 777 /uml_rootfs/init.sh
sudo mkdir -p /uml_rootfs/etc/network
echo '/dev/ubd0 / ext4 defaults 0 0' | sudo tee /uml_rootfs/etc/fstab
echo 'nameserver 1.1.1.1' | sudo tee /uml_rootfs/etc/resolv.conf
echo 'ip link set dev eth0 up' | sudo tee /uml_rootfs/etc/init/network.conf
echo 'ip a add 192.168.1.24 dev eth0' | sudo tee -a /uml_rootfs/etc/init/network.conf
echo 'ip route add default via 192.168.1.48' | sudo tee -a /uml_rootfs/etc/init/network.conf

./umount.sh
