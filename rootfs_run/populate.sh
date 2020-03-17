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
sed -i -e "s/robbyrussell/rkj\-repos/g" /root/.zshrc;
echo "/dev/ubd0 / ext4 defaults 0 0" > /etc/fstab;
echo "[Unit]
Description=Initial Network Config
After=network-online.target

[Service]
Type=oneshot
RemainAfterExit=yes
ExecStart=/bin/sh -c \"ip link set dev eth0 up; ip a add 192.168.1.24/24 dev eth0; ip route add default via 192.168.1.48;\"

[Install]
WantedBy=multi-user.target
" > /etc/systemd/system/init_network.service;
systemctl enable init_network.service;
echo "nameserver 1.1.1.1" > /etc/resolv.conf;
'
./umount.sh
