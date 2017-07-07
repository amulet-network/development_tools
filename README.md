# Amulet Development

Repository for tools used to develop Amulet.

## Instructions

This will set up all the tools needed for development, as well as a private
network that testing & mining can be run on. Mining is setup to be cheap to
allow for coins to be mined easily.

1. Run `./install.sh` to install solidity and geth via Brew.
  * Will install devtools, git and brew if not already installed.
2. Run `./create_private_network.sh` to create a private network.
3. Run `./start_private_console.sh` to run a console on the private network.

## Mining

There are no accounts created by default, so run `./start_private_console.sh`
and then do the following:

```bash
> personal.newAccount('testing')
> miner.start(1)
```

This will start mining coin into your test account. You can check its balance
by running the following:

```bash
web3.fromWei(eth.getBalance(eth.coinbase), "ether")
```
