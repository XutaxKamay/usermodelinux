mkdir -p uml
cp -r -p /media/sda2/git/zen-kernel ./uml
mv uml/zen-kernel/* uml/
mv uml/zen-kernel/.* uml/
rm uml/zen-kernel/ -rf

version_makefile=$(cat ./uml/Makefile|grep "VERSION = [0-9]")
patchlevel_makefile=$(cat ./uml/Makefile|grep "PATCHLEVEL = [0-9]")
sublevel_makefile=$(cat ./uml/Makefile|grep "SUBLEVEL = [0-9]")
extraversion_makefile=$(cat ./uml/Makefile|grep "EXTRAVERSION = [a-zA-Z0-9_.-]")

new_version_makefile="VERSION = 5"
new_patchlevel_makefile='PATCHLEVEL ='
new_sublevel_makefile='SUBLEVEL ='
new_extraversion_makefile='EXTRAVERSION ='


sed -i "s/$version_makefile/$new_version_makefile/g" ./uml/Makefile
sed -i "s/$patchlevel_makefile/$new_patchlevel_makefile/g" ./uml/Makefile
sed -i "s/$sublevel_makefile/$new_sublevel_makefile/g" ./uml/Makefile
sed -i "s/$extraversion_makefile/$new_extraversion_makefile/g" ./uml/Makefile

echo 'Done'
ln -s ~/uml/scripts/kernel/kernelconfig ./uml/.config
notify-send 'Done configurating and extracting kernel'
