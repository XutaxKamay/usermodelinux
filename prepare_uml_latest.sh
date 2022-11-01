echo 'Downloading lastest kernel'
start_link='https://cdn.kernel.org/pub/linux/kernel/'
result=$(wget -q -O - https://www.kernel.org|grep -F "<a href=\"$start_link"|head -1|cut -d '"' -f2)
kernel_version=$(echo $result|cut -d '/' -f8)
kernel_main_version=$(echo $result|cut -d '/' -f7|cut -d '.' -f1|cut -d 'v' -f2)
echo "Downloading $kernel_version"
wget -N -c -O ./uml.tar.gz $result
echo 'Extracting...'
mkdir -p uml
tar -xf uml.tar.gz --strip 1 -C ./uml/

version_makefile=$(cat ./uml/Makefile|grep "VERSION = [0-9]")
patchlevel_makefile=$(cat ./uml/Makefile|grep "PATCHLEVEL = [0-9]")
sublevel_makefile=$(cat ./uml/Makefile|grep "SUBLEVEL = [0-9]")

new_version_makefile="VERSION = $kernel_main_version"
new_patchlevel_makefile='PATCHLEVEL ='
new_sublevel_makefile='SUBLEVEL ='


sed -i "s/$version_makefile/$new_version_makefile/g" ./uml/Makefile
sed -i "s/$patchlevel_makefile/$new_patchlevel_makefile/g" ./uml/Makefile
sed -i "s/$sublevel_makefile/$new_sublevel_makefile/g" ./uml/Makefile

echo 'Done'
ln -s ../kernel/kernelconfig ./uml/.config
notify-send 'Done configurating and extracting kernel'
