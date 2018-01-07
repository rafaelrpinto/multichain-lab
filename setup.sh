#!/bin/bash

BLOCKCHAIN_NAME="chain1"
NETWORK_PORT=4407
RPC_PORT=4406

# Installs avahi daemon
apt-get install -y avahi-daemon libnss-mdns

# Disables firewall to make tests easier
ufw --force disable

# Installs multichain 
cd /tmp
wget https://www.multichain.com/download/multichain-latest.tar.gz
tar -xvzf multichain-*.tar.gz
cd multichain-*
mv multichaind multichain-cli multichain-util /usr/local/bin

# Specific provision
if [ "$HOSTNAME" = node1 ]; then
	# Creaates the blockchain as the vagrant user
	su - vagrant -c "multichain-util create $BLOCKCHAIN_NAME"
	# Sets the predefined ports on the blockchain config file
	sed -i "/default-network-port*/c\default-network-port = ${NETWORK_PORT}" /home/vagrant/.multichain/$BLOCKCHAIN_NAME/params.dat
	sed -i "/default-rpc-port*/c\default-rpc-port = ${RPC_PORT}" /home/vagrant/.multichain/$BLOCKCHAIN_NAME/params.dat
	# Starts the blockchain daemon
	su - vagrant -c "multichaind $BLOCKCHAIN_NAME -daemon"
else
    printf "ssh to $HOSTNAME and execute: multichaind $BLOCKCHAIN_NAME@10.0.0.11:$NETWORK_PORT"
	printf "after granting access on node1 execute: multichaind $BLOCKCHAIN_NAME -daemon"
fi
