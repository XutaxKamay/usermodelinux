rm ~/.uml -rf
linux rootfstype=hostfs rw init=$HOME/uml/init.sh mem=128M umid=linuxdbg
