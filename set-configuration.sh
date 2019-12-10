#
sudo systemctl stop scylla-server
#
sudo sh -c "cat scylla.yaml > /etc/scylla/scylla.yaml"
#
sudo systemctl start scylla-server
#
sudo systemctl status scylla-server
#
