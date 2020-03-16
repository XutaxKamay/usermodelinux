rm ~/.uml -rf
linux rootfstype=hostfs rw init=$HOME/uml/host_run/init.sh mem=2048M umid=linuxdbg 
