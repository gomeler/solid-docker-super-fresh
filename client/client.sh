#!/bin/bash


source /etc/client/creds.rc

function glance_bootstrap {
    echo "Glance Bootstrap"
    openstack user create --domain default --password password glance
    openstack role add --project service --user glance admin
    openstack service create --name glance --description "OpenStack Image" image
    openstack endpoint create --region RegionOne image public http://glance-api:9292
    openstack endpoint create --region RegionOne image internal http://glance-api:9292
    openstack endpoint create --region RegionOne image admin http://glance-api:9292
}

openstack project create --domain default --description "Service Project" service

openstack user create --domain default --password password cinder
openstack role add --project service --user cinder admin

openstack service create --name cinderv2 --description "OpenStack Block Storage" volumev2
openstack service create --name cinderv3 --description "OpenStack Block Storage" volumev3

openstack endpoint create --region RegionOne volumev2 public http://cinder-api:8776/v2/%\(project_id\)s
openstack endpoint create --region RegionOne volumev2 internal http://cinder-api:8776/v2/%\(project_id\)s
openstack endpoint create --region RegionOne volumev2 admin http://cinder-api:8776/v2/%\(project_id\)s

openstack endpoint create --region RegionOne volumev3 public http://cinder-api:8776/v3/%\(project_id\)s
openstack endpoint create --region RegionOne volumev3 internal http://cinder-api:8776/v3/%\(project_id\)s
openstack endpoint create --region RegionOne volumev3 admin http://cinder-api:8776/v3/%\(project_id\)s

if [ "$INIT_GLANCE" = "true" ]; then
    glance_bootstrap
fi


while [[ ! -f /tmp/stop ]]; do
    sleep 1
done
