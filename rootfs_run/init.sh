#!/bin/sh

mount -t proc proc proc/
mount -t sysfs sys sys/

# Network configuration
ip link set dev eth0 up
ip a add 192.168.1.24/24 dev eth0       
ip route add default via 192.168.1.48

HOME=/root
SHELL=/bin/zsh
TERM=xterm-256color
USER=root
LOGNAME=root
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games
PROFILEHOME=

# Just in case for errors
export ZSH_DISABLE_COMPFIX="true"

exec /bin/sh

