sudo rm ~/.uml -rf
ip=$(ip a | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' | head -1)
echo "Setting tuntap to host ip $ip"
./network.sh
linux ubd0=rootfs-image mem=512M umid=linuxdbg_rootfs rw root=/dev/ubda eth0=tuntap,,,$ip #on=pts con0=fd:0,fd:1
