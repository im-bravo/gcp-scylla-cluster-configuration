#!/bin/bash
my_internal_ip_address() {
    /sbin/ip -o -4 addr list ens4 | awk '{print $4}' | cut -d/ -f1
}

export SELF_HOST_INTERNAL_IP=`my_internal_ip_address`
cqlsh $SELF_HOST_INTERNAL_IP
