#!/bin/sh 
#TODO: egrep -c '(vmx|svm)' /proc/cpuinfo, if greater than 0, then kvm is okay, otherwise need to use the qemu conf file.
mkdir /opt/nova/
mkdir /opt/nova/instances
mkdir /var/log/nova/
service libvirtd restart
#cp /etc/nova/nova.conf.qemu /etc/nova/nova.conf

# nova-compute and neutron-linuxbridge-agent use the same conf file with different local_ip values. Ansible would be nice, or could use sed.
cp -r /etc/neutron_base /etc/neutron
cp /etc/neutron/plugins/ml2/linuxbridge_agent.ini.compute /etc/neutron/plugins/ml2/linuxbridge_agent.ini

nova-compute -d &
neutron-linuxbridge-agent --config-file /etc/neutron/neutron.conf --config-file /etc/neutron/plugins/ml2/ml2_conf.ini --config-file /etc/neutron/plugins/ml2/linuxbridge_agent.ini --debug &

wait
