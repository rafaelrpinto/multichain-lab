vagrant up

vagrant ssh node2

multichaind chain1@10.0.0.11:4407

vagrant ssh node2

multichain-cli chain1 grant 1964NwjxDMjH7ftS2UBRg793hijHobgqnj1CQR connect
multichain-cli chain1 grant 1964NwjxDMjH7ftS2UBRg793hijHobgqnj1CQR connect,send,receive

vagrant ssh node1

multichaind chain1 -daemon
