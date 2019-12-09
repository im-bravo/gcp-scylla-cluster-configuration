# gcp-scylla-cluster-configuration

```sh
# SEEDS_IP_ADDRESS
# LISTEN_IP_ADDRESS
# RPC_IP_ADDRESS

export SEEDS_IP_ADDRESS=`nslookup your-instance-name | grep Address | tail -1 | cut -d:  -f2 | sed 's/^ *\| *$//'`
export LISTEN_IP_ADDRESS=`/sbin/ip -o -4 addr list ens4 | awk '{print $4}' | cut -d/ -f1`
export RPC_IP_ADDRESS=`/sbin/ip -o -4 addr list ens4 | awk '{print $4}' | cut -d/ -f1`

cp scylla.edit.yaml scylla.yaml
sed -i "s/SEEDS_IP_ADDRESS/${SEEDS_IP_ADDRESS}/g" scylla.yaml
sed -i "s/LISTEN_IP_ADDRESS/${LISTEN_IP_ADDRESS}/g" scylla.yaml
sed -i "s/RPC_IP_ADDRESS/${RPC_IP_ADDRESS}/g" scylla.yaml

sudo sh -c "cat scylla.yaml > /etc/scylla/scylla.yaml"

sudo systemctl stop scylla-server
sudo systemctl start scylla-server
sudo systemctl status scylla-server

cqlsh $LISTEN_IP_ADDRESS
```
