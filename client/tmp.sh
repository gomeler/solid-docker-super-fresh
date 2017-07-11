openstack network create  --share --external \
  --provider-physical-network provider \
  --provider-network-type flat provider


openstack subnet create --network provider \
  --allocation-pool start=172.49.49.25,end=172.49.49.35 \
  --dns-nameserver 8.8.8.8 --gateway 172.49.49.1 \
  --subnet-range 172.49.49.0/24 provider

wget http://download.cirros-cloud.net/0.3.5/cirros-0.3.5-x86_64-disk.img

openstack image create "cirros" \
  --file cirros-0.3.5-x86_64-disk.img \
  --disk-format qcow2 --container-format bare \
  --public


openstack flavor create --id 0 --vcpus 1 --ram 64 --disk 1 m1.nano

ssh-keygen -q -N "" -f /root/.ssh/id_rsa
openstack keypair create --public-key ~/.ssh/id_rsa.pub mykey

openstack security group rule create --proto icmp default

openstack security group rule create --proto tcp --dst-port 22 default

net_id=NONE

openstack server create --flavor m1.nano --image cirros \
  --nic net-id=$net_id --security-group default \
  --key-name mykey provider-instance
