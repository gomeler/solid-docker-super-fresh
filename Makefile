CINDER_BRANCH ?= master # master, stable/ocata, refs/changes/67/418167/1
NAME_PREFIX ?= ""
PLATFORM ?= debian # ubuntu, centos
TAG ?= latest

all: base lvm client-img keystone-img glance-img nova-img neutron-img horizon-img

base:
	docker build https://git.openstack.org/openstack/loci-cinder.git\#:$(PLATFORM) --tag cinder:$(TAG) --build-arg PROJECT_REF="stable/ocata"

lvm:
	docker build -t cinder-lvm -f ./dockerfiles/cinder/Dockerfile.cinder-lvm .

client-img:
	docker build -t test:client -f ./dockerfiles/client/Dockerfile .

keystone-img:
	docker build -t test:keystone -f ./dockerfiles/keystone/Dockerfile .

glance-img:
	docker build -t test:glance -f ./dockerfiles/glance/Dockerfile .

nova-img:
	docker build -t test:nova -f ./dockerfiles/nova/Dockerfile .

neutron-img:
	docker build -t test:neutron -f ./dockerfiles/neutron/Dockerfile .

horizon-img:
	docker build -t test:horizon2 -f ./dockerfiles/horizon2/Dockerfile .
