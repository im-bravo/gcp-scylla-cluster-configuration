#
sudo systemctl stop scylla-server
#
sudo sh -c "cat scylla.yaml > /etc/scylla/scylla.yaml"
#
sudo sh -c "cat cassandra-rackdc.properties > /etc/scylla/cassandra-rackdc.properties"
# 
sudo rm -rf /var/lib/scylla/commitlog/*
sudo rm -rf /var/lib/scylla/data/*
#
sudo systemctl start scylla-server
#
sudo systemctl status scylla-server
#
