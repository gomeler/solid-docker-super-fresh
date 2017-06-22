#!/bin/sh 
#TODO: egrep -c '(vmx|svm)' /proc/cpuinfo, if greater than 0, then kvm is okay, otherwise need to use the qemu conf file.
mkdir /opt/nova/
mkdir /opt/nova/instances
service libvirtd restart
cp /etc/nova/nova.conf.qemu /etc/nova/nova.conf
nova-compute -d
