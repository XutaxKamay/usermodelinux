sudo rm ~/.uml -rf
ip=$(ip a | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')
echo "Setting tuntap to host ip $ip"
./network.sh
./mount.sh
OLDPWD=$PWD
cd ~/projects/XLib/linux_kernel_module/um
make
sudo cp custom_module.ko /uml_rootfs/root
cd $OLDPWD
linux rootfstype=hostfs rootflags=/uml_rootfs rw mem=512M umid=linuxdbg_rootfs eth0=tuntap,,,$ip rw root=/dev/ubda #con=pts con0=fd:0,fd:1
