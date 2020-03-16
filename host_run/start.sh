rm ~/.uml -rf
linux rootfstype=hostfs rw init=$HOME/uml/init.sh mem=2048M umid=linuxdbg 
