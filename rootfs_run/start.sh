rm ~/.uml -rf
linux rootfstype=hostfs rootflags=$HOME/uml/rootfs rw init=/init.sh mem=2048M umid=linuxdbg_hostfs eth0=tuntap,,,192.168.1.48
