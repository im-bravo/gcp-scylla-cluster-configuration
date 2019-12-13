#
sudo systemctl stop cassandra
#
sudo sh -c "cat cassandra.yaml > /etc/cassandra/cassandra.yaml"
#
sudo sh -c "cat cassandra-rackdc.properties > /etc/cassandra/cassandra-rackdc.properties"
# 
sudo rm -rf /var/lib/cassandra/*
#
sudo systemctl restart cassandra
#
sudo systemctl status cassandra
#
