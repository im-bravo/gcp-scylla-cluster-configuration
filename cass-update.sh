#
sudo systemctl stop cassandra
#
sudo sh -c "cat cassandra.yaml > /etc/cassandra/cassandra.yaml"
#
sudo sh -c "cat cassandra-rackdc.properties > /etc/cassandra/cassandra-rackdc.properties"
# 
sudo rm -rf /var/lib/cassandra/data/*
sudo rm -rf /var/lib/cassandra/hints/*
sudo rm -rf /var/lib/cassandra/commitlog/*

#
sudo systemctl restart cassandra
#
sudo systemctl status cassandra
#
