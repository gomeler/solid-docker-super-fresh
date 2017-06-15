#!/bin/bash


source /etc/client/creds.rc

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

while [[ ! -f /tmp/stop ]]; do
    sleep 1
done
