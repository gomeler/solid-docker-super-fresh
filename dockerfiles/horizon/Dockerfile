FROM ubuntu:zesty

RUN DEBIAN_FRONTEND=noninteractive apt update \
&& apt install -y --no-install-recommends \
vim python-pip git build-essential libssl-dev libffi-dev python-dev \
netbase


RUN pip install -U pip
RUN pip install setuptools
RUN pip install pytz repoze.lru pymysql
RUN pip install -U cffi

RUN cd /root/ && git clone https://git.openstack.org/openstack/horizon.git
RUN cd /root/horizon && pip install .
