#!/bin/bash
# -- configuration
# DC 1
export DC1_NODE1=simba-db-usw1a-01
export DC1_NODE2=simba-db-usw1a-02
export DC1_NODE3=simba-db-usw1a-03

# DC 2
export DC2_NODE1=simba-db-useast-01
export DC2_NODE2=simba-db-useast-02
export DC2_NODE3=simba-db-useast-03

# get internal IP address by instance name
get_internal_ip_address() {
    echo `nslookup $1 | grep Address | tail -1 | cut -d:  -f2 | sed 's/^ *\| *$//'`
}

# create scylla yaml file
create_scylla_yaml() {
    # 
    export L_SEEDS_IP_ADDRESS=$1
    export L_LISTEN_IP_ADDRESS=$2
    export L_RPC_IP_ADDRESS=$3
    export L_API_IP_ADDRESS=$4
    # 
    cp scylla.edit.yaml scylla.yaml
    sed -i "s/L_SEEDS_IP_ADDRESS/${SEEDS_IP_ADDRESS}/g" scylla.yaml
    sed -i "s/L_LISTEN_IP_ADDRESS/${LISTEN_IP_ADDRESS}/g" scylla.yaml
    sed -i "s/L_RPC_IP_ADDRESS/${RPC_IP_ADDRESS}/g" scylla.yaml
    sed -i "s/L_API_IP_ADDRESS/${API_IP_ADDRESS}/g" scylla.yaml
}

export DC1_NODE1_INTERNAL_IP=`get_internal_ip_address $DC1_NODE1`
export DC1_NODE2_INTERNAL_IP=`get_internal_ip_address $DC1_NODE2`
export DC1_NODE3_INTERNAL_IP=`get_internal_ip_address $DC1_NODE3`

export DC2_NODE1_INTERNAL_IP=`get_internal_ip_address $DC2_NODE1`
export DC2_NODE2_INTERNAL_IP=`get_internal_ip_address $DC2_NODE2`
export DC2_NODE3_INTERNAL_IP=`get_internal_ip_address $DC2_NODE3`


export SEEDS_IP_LIST="$DC1_NODE1_INTERNAL_IP,$DC1_NODE2_INTERNAL_IP,$DC2_NODE1_INTERNAL_IP,$DC2_NODE2_INTERNAL_IP"

echo $SEEDS_IP_LIST

# 
# sudo sh -c "echo 'dc=simba-scylla-dc2' >> /etc/scylla/cassandra-rackdc.properties"
# sudo sh -c "echo 'rack=rackuseast01' >> /etc/scylla/cassandra-rackdc.properties"




