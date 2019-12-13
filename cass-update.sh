#
sudo systemctl stop cassandra
#
sudo sh -c "cat cassandra.yaml > /etc/cassandra/scylla.yaml"
#
sudo sh -c "cat cassandra-rackdc.properties > /etc/scylla/cassandra-rackdc.properties"
# 
sudo rm -rf /var/lib/cassandra/*
#
sudo systemctl start cassandra
#
sudo systemctl status cassandra
#
