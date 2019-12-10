# gcp-scylla-cluster-configuration

# -- configuration
# please set your host name
# DC 1
export DC1_NODE1=xxx-01
export DC1_NODE2=xxx-02
export DC1_NODE3=xxx-03

# DC 2
export DC2_NODE1=xxx-01
export DC2_NODE2=xxx-02
export DC2_NODE3=xxx-03

# generate configuration file
sh multi-data-center.sh your-cluster-name

# update service configuration file
# All existing data will be deleted
sh update.sh

# utility
sudo systemctl stop scylla-server
sudo systemctl start scylla-server
sudo systemctl status scylla-server
