FROM debian:latest

RUN DEBIAN_FRONTEND=noninteractive apt update \
&& apt install -y --no-install-recommends \
vim python-pip git build-essential libssl-dev libffi-dev python-dev \
bridge-utils conntrack ebtables init-system-helpers dnsmasq-base \
dnsmasq-utils iptables sudo

RUN pip install pytz repoze.lru pymysql
RUN pip install -U cffi

RUN cd /root/ && git clone https://git.openstack.org/openstack/neutron.git
RUN cd /root/neutron && pip install .
