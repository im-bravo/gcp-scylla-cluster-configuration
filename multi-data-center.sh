#!/bin/bash
# -- configuration
# DC 1
# export DC1_NODE1=xxxx-01
# export DC1_NODE2=xxxx-02
# export DC1_NODE3=xxxx-03

# DC 2
# export DC2_NODE1=yyyy-01
# export DC2_NODE2=yyyy-02
# export DC2_NODE3=yyyy-03
export CLUSTER_NAME=$1

# get internal IP address by instance name
get_internal_ip_address() {
    nslookup $1 | grep Address | tail -1 | cut -d:  -f2 | sed 's/^ *\| *$//'
}

my_internal_ip_address() {
    /sbin/ip -o -4 addr list ens4 | awk '{print $4}' | cut -d/ -f1
}


# create scylla yaml file
create_scylla_yaml() {
    # 
    export L_SEEDS_IP_ADDRESS=$1
    export L_LISTEN_IP_ADDRESS=$2
    export L_RPC_IP_ADDRESS=$3
    export L_API_IP_ADDRESS=$4
    # edit
    cp scylla.edit.yaml scylla.yaml
    sed -i "s/L_SEEDS_IP_ADDRESS/${SEEDS_IP_ADDRESS}/g" scylla.yaml
    sed -i "s/L_LISTEN_IP_ADDRESS/${LISTEN_IP_ADDRESS}/g" scylla.yaml
    sed -i "s/L_RPC_IP_ADDRESS/${RPC_IP_ADDRESS}/g" scylla.yaml
    sed -i "s/L_API_IP_ADDRESS/${API_IP_ADDRESS}/g" scylla.yaml
    sudo sh -c "echo cluster_name: '$CLUSTER_NAME' >> scylla.yaml"
    # diff
    diff scylla.edit.yaml scylla.yaml
}

check_dc() {
    if $1 -eq $2 ; then
        return 1
    fi
    if $1 -eq $3 ; then
        return 1
    fi
    if $1 -eq $4 ; then
        return 01
    fi
    return 0
}


export DC1_NODE1_INTERNAL_IP=`get_internal_ip_address $DC1_NODE1`
export DC1_NODE2_INTERNAL_IP=`get_internal_ip_address $DC1_NODE2`
export DC1_NODE3_INTERNAL_IP=`get_internal_ip_address $DC1_NODE3`

export DC2_NODE1_INTERNAL_IP=`get_internal_ip_address $DC2_NODE1`
export DC2_NODE2_INTERNAL_IP=`get_internal_ip_address $DC2_NODE2`
export DC2_NODE3_INTERNAL_IP=`get_internal_ip_address $DC2_NODE3`

export SEEDS_IP_LIST="$DC1_NODE1_INTERNAL_IP,$DC1_NODE2_INTERNAL_IP,$DC2_NODE1_INTERNAL_IP,$DC2_NODE2_INTERNAL_IP"
export SELF_HOST_INTERNAL_IP=`my_internal_ip_address`

echo $SEEDS_IP_LIST
echo $SELF_HOST_INTERNAL_IP

# create config file. "scylla.yaml"
create_scylla_yaml $SEEDS_IP_LIST $SELF_HOST_INTERNAL_IP $SELF_HOST_INTERNAL_IP $SELF_HOST_INTERNAL_IP

# check dc
check_dc $SELF_HOST_INTERNAL_IP $DC1_NODE1_INTERNAL_IP $DC1_NODE2_INTERNAL_IP $DC1_NODE3_INTERNAL_IP
export DC_IS_DC1=$?
check_dc $SELF_HOST_INTERNAL_IP $DC2_NODE1_INTERNAL_IP $DC2_NODE2_INTERNAL_IP $DC2_NODE3_INTERNAL_IP
export DC_IS_DC2=$?

if $DC_IS_DC1 = 1; then
    export DC_NAME="SSDC1"
fi
if $DC_IS_DC2 = 1; then
    export DC_NAME="SSDC2"
fi

echo "My Data Center: $DC_NAME"


cp cassandra-rackdc.example.properties cassandra-rackdc.properties
# 
echo "dc=$DC_NAME" >> cassandra-rackdc.properties
echo 'rack=RAK1' >> cassandra-rackdc.properties

diff cassandra-rackdc.example.properties cassandra-rackdc.properties


# cp /etc/scylla/scylla.yaml ./scylla.yaml.backup
# sudo sh -c "cat scylla.yaml > /etc/scylla/scylla.yaml"



