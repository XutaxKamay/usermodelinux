./umount.sh
./mount.sh
sudo /uml_rootfs/bin/arch-chroot \
/uml_rootfs /bin/bash -c '
export HOME=/root;
pacman-key --init;
pacman-key --populate archlinux;
echo "Server = https://mirror.oldsql.cc/archlinux/\$repo/os/\$arch" > /etc/pacman.d/mirrorlist;
pacman -Syyu base which iproute2 openssh zsh wget git vim rng-tools pwndbg gcc checksec ropper ropgadget radare2 --noconfirm;
echo "Creating udb0";
mknod --mode=777 /dev/ubd0 b 98 0;
chown root:disk /dev/ubd0;
echo "root:tlxkjc" | chpasswd;
chsh -s /bin/zsh;
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended;
sed -i -e "s/robbyrussell/rkj\-repos/g" /root/.zshrc;
echo "/dev/ubd0 / ext4 defaults 0 0" > /etc/fstab;
sed -i -e "s/#PermitRootLogin prohibit\-password/PermitRootLogin yes/g" /etc/ssh/sshd_config;        
sed -i -e "/#ListenAddress 0/s/^#//g" /etc/ssh/sshd_config;        
systemctl enable sshd;
systemctl enable rngd;
echo "source /usr/share/pwndbg/gdbinit.py" > /root/.gdbinit;
echo "set follow-fork-mode parent" >> /root/.gdbinit;
echo "set history filename ~/.gdb_history" >> /root/.gdbinit;
'
OLDPWD=$PWD
cd /lib/modules/uml/build/
if [ $? -eq 0 ]; then
    sudo make ARCH=um modules_install INSTALL_MOD_PATH=/uml_rootfs
fi
cd $OLDPWD
./network.sh
./umount.sh
