FROM debian:stretch

RUN DEBIAN_FRONTEND=noninteractive apt update \
&& apt install -y --no-install-recommends \
vim python-pip git build-essential libssl-dev libffi-dev python-dev \
iptables novnc python-libvirt libvirt-daemon-system libvirt-clients \
open-iscsi qemu-utils \
qemu bridge-utils conntrack ebtables init-system-helpers dnsmasq-base \
dnsmasq-utils sudo netbase iproute

RUN pip install -U pip
RUN pip install setuptools
RUN pip install pytz repoze.lru pymysql
RUN pip install -U cffi

RUN cd /root/ && git clone https://git.openstack.org/openstack/nova.git
RUN cd /root/nova && pip install .

#TODO: We should use the Neutron image as the base image.
RUN cd /root/ && git clone https://git.openstack.org/openstack/neutron.git
RUN cd /root/neutron && pip install .
