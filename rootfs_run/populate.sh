./mount.sh
sudo /uml_rootfs/bin/arch-chroot \
/uml_rootfs /bin/bash -c '
export HOME=/root;
pacman-key --init;
pacman-key --populate archlinux;
echo "Server = https://mirror.oldsql.cc/archlinux/\$repo/os/\$arch" > /etc/pacman.d/mirrorlist;
pacman -Syyu base which iproute2 openssh zsh wget git vim --noconfirm;
echo "Creating udb0";
mknod --mode=777 /dev/ubd0 b 98 0;
chown root:disk /dev/ubd0;
echo "root:tlxkjc" | chpasswd;
chsh -s /bin/zsh;
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended;
echo "/dev/ubd0 / ext4 defaults 0 0" > /etc/fstab;
echo "
[Match]
Name=eth0
 
[Network]
Address=192.168.1.24/24
Gateway=192.168.1.48
DNS=1.1.1.1
" > /etc/systemd/network/eth0.network;
sed -i -e "s/robbyrussell/rkj\-repos/g" /root/.zshrc'
./umount.sh
