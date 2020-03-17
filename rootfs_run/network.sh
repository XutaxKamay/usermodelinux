./umount.sh
./mount.sh
sudo /uml_rootfs/bin/arch-chroot \
/uml_rootfs /bin/bash -c '
export HOME=/root;
echo "[Unit]
Description=Initial Network Config
After=network-online.target

[Service]
Type=oneshot
RemainAfterExit=yes
ExecStart=/bin/sh -c \"ip link set dev eth0 up; ip a add 192.168.1.24/24 dev eth0; ip route add default via $(ip a | grep -Eo "inet (addr:)?([0-9]*\.){3}[0-9]*" | grep -Eo "([0-9]*\.){3}[0-9]*" | grep -v "127.0.0.1"); echo \\\"nameserver 1.1.1.1\\\" > /etc/resolv.conf\"

[Install]
WantedBy=multi-user.target
" > /etc/systemd/system/init_network.service;
'
./umount.sh
