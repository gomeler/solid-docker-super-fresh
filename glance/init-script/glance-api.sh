#!/bin/bash

INIT_DB=${INIT_DB:-true}

if [ "$INIT_DB" = "true" ]; then
/bin/sh -c "glance-manage db sync" glance
fi

glance-api
