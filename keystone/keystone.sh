#!/bin/bash

set -eux

function fresh_bootstrap {
    #cd /root/ && git clone https://git.openstack.org/openstack/keystone.git
    #cd /root/keystone && pip install .

    cd /root/keystone/
    mkdir /etc/keystone/
    cp /etc/keystone_cp/keystone.conf /etc/keystone/
    cp /etc/keystone_cp/keystone-paste.ini /etc/keystone/
    cp etc/default_catalog.templates /etc/keystone/
    cp etc/logging.conf.sample /etc/keystone/logging.conf
    cp etc/policy.v3cloudsample.json /etc/keystone/
    cp etc/sso_callback_template.html /etc/keystone/

    addgroup keystone
    adduser --ingroup keystone --no-create-home --disabled-password --gecos "" keystone

    keystone-manage db_sync

    keystone-manage fernet_setup --keystone-user keystone --keystone-group keystone
    keystone-manage credential_setup --keystone-user keystone --keystone-group keystone

    keystone-manage bootstrap --bootstrap-password password --bootstrap-admin-url http://172.49.49.4:35357/v3 --bootstrap-public-url http://172.49.49.4:5000/v3 --bootstrap-internal-url http://172.49.49.4:5000/v3 --bootstrap-service-name ayyy --bootstrap-region-id RegionBest

    #echo "ServerName 172.49.49.7" >> /etc/apache2/apache2.conf

    #service apache2 restart
    #rm -f /var/lib/keystone/keystone.db

}

#if [[ ${KEYSTONE_BOOTSTRAP} == 1 ]]; then
#    bootstrap
#fi
# For now we bootstrap every time.
fresh_bootstrap

#while [[ ! -f /tmp/stop ]]; do
#    sleep 1
#done

keystone-wsgi-admin --port 35357 &
keystone-wsgi-public --port 5000 &
wait

