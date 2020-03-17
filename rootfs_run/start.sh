rm ~/.uml -rf
linux ubd0=rootfs-image mem=512M umid=linuxdbg_rootfs eth0=tuntap,,,192.168.1.48 rw root=/dev/ubda con=pts con0=fd:0,fd:1 
