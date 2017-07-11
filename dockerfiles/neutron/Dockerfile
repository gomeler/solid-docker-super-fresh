FROM debian:latest
#FROM ubuntu:zesty

#NOTE: ebtables MUST be installed on the docker host. Otherwise, neutron-linuxbridge-agent will not work due to an ebtables error.

RUN DEBIAN_FRONTEND=noninteractive apt update \
&& apt install -y --no-install-recommends \
vim python-pip git build-essential libssl-dev libffi-dev python-dev \
bridge-utils conntrack ebtables init-system-helpers dnsmasq-base \
dnsmasq-utils iptables sudo netbase iproute

RUN pip install -U pip
RUN pip install setuptools
RUN pip install pytz repoze.lru pymysql
RUN pip install -U cffi

RUN cd /root/ && git clone https://git.openstack.org/openstack/neutron.git
RUN cd /root/neutron && pip install .
