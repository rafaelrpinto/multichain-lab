### Overview

Simple scripts to create a private blackchain based on [Multichain](https://www.multichain.com) using ubuntu vms.

You need vagrant installed to be able to create the vms.

### Setup

Checkout the project and customize the `Vagrantfile` / `setup.sh` to the values you desire. The default values are.

```
BOX_IMAGE = "ubuntu/trusty64"
NODE_COUNT = 2
BLOCKCHAIN_NAME="chain1"
NETWORK_PORT=4407
RPC_PORT=4406
```

Run `vagrant up` to autimatically create all the nodes with multichain binaries on it and setup the seed node of the blockchain on node1.

Assuming the configuration on Vagrantfile wasn't changed you need to ssh to node2:

`vagrant ssh node2`

And attempt to connect to the seed node:

`multichaind chain1@10.0.0.11:4407`

This should output a message requiring node1 to give access to node2:

```
multichain-cli chain1 grant XXXXXXXXXXXXXXXXXXXX connect,send,receive
```

Copy the output command and ssh to node1

`vagrant ssh node1`

Paste the command to give permissions. The output should be something like:

```
vagrant@node1:~$ multichain-cli chain1 grant 1TqJ1onKCDjnGPoo2tSHf6mVWXb4tS4mksLKR2 connect,send,receive
{"method":"grant","params":["1TqJ1onKCDjnGPoo2tSHf6mVWXb4tS4mksLKR2","connect,send,receive"],"id":1,"chain_name":"chain1"}

f7a99b945947a0080510299966648522fb2190b2edaf5e2841bbcc47eb73666e
```

Return to node2 to start the server.

`vagrant ssh node2`

Start the node:

`multichaind chain1 -daemon`

Now you have 2 nodes on your private blockchain.

### Cheat Sheet

Issue new assets. Ex: Issue 1000 asset1 which can be divided in groups of 100.

`issue <address id> asset1 1000 0.01`

Get the address id of a node:

`getaddressesbyaccount ""`

Transfer 100 asset1 to other address:

`sendasset <target address> asset1 100`

Get the balance of a wallet:

`gettotalbalances`

Lists a wallet's transactions:

`listwallettransactions 1`
