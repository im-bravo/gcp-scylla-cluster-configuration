
# sh refresh.sh seed-instance1,2
export SEEDS_IP_ADDRESS=`nslookup $1 | grep Address | tail -1 | cut -d:  -f2 | sed 's/^ *\| *$//'`


export SELF_HOST_IP_ADDRESS=`/sbin/ip -o -4 addr list ens4 | awk '{print $4}' | cut -d/ -f1`
export LISTEN_IP_ADDRESS=$SELF_HOST_IP_ADDRESS
export RPC_IP_ADDRESS=$SELF_HOST_IP_ADDRESS
export API_IP_ADDRESS=$SELF_HOST_IP_ADDRESS


cp scylla.edit.yaml scylla.yaml
sed -i "s/SEEDS_IP_ADDRESS/${SEEDS_IP_ADDRESS}/g" scylla.yaml
sed -i "s/LISTEN_IP_ADDRESS/${LISTEN_IP_ADDRESS}/g" scylla.yaml
sed -i "s/RPC_IP_ADDRESS/${RPC_IP_ADDRESS}/g" scylla.yaml
sed -i "s/API_IP_ADDRESS/${API_IP_ADDRESS}/g" scylla.yaml
diff scylla.edit.yaml scylla.yaml

cp /etc/scylla/scylla.yaml ./scylla.yaml.backup
sudo sh -c "cat scylla.yaml > /etc/scylla/scylla.yaml"

sudo systemctl stop scylla-server
sudo systemctl start scylla-server
sudo systemctl status scylla-server

