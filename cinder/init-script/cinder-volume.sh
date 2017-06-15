#!/usr/bin/env bash

truncate --size=10G cinder-volumes.img
# Get next available loop device
LD=$(sudo losetup -f)
losetup $LD cinder-volumes.img
sfdisk /dev/loop0 << EOF
,,8e,,
EOF
pvcreate $LD
vgcreate cinder-volumes $LD
/usr/sbin/tgtd && cinder-volume -d


#TODO:modprobe dm_thin_pool and maybe sudo apt-get install thin-provisioning-tools
