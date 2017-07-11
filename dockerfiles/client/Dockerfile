FROM debian:stretch

RUN DEBIAN_FRONTEND=noninteractive apt update \
&& apt install -y --no-install-recommends \
vim python-pip git build-essential libssl-dev libffi-dev python-dev \
openssh-client wget

RUN pip install -U pip
RUN pip install setuptools
RUN pip install pytz repoze.lru pymysql
RUN pip install -U cffi
RUN pip install python-openstackclient
