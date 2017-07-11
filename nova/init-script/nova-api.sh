#!/bin/bash
INIT_DB=${INIT_DB:-true}

if [ "$INIT_DB" = "true" ]; then
    /bin/sh -c "nova-manage api_db sync" nova
    /bin/sh -c "nova-manage cell_v2 map_cell0" nova
    /bin/sh -c "nova-manage cell_v2 create_cell --name=cell1 --verbose" nova
    /bin/sh -c "nova-manage db sync" nova
fi

#TODO: start the various nova services.
mkdir /var/log/nova/
nova-api -d &
nova-metadata-wsgi &
#TODO: Need to programatically trigger this, or configure nova to scan for hosts.
sleep 30;
nova-manage cell_v2 discover_hosts --verbose;
wait
