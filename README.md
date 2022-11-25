# Defi-Hacks-Recreated
Proof of concept exploits reproducing the largest smart contract exploits

## Setup

Install foundry with the setup instructions here: 

https://book.getfoundry.sh/getting-started/installation

Acquire an RPC url from here: https://dashboard.alchemy.com/

And set the https rpc url as an environment variable via:

```
export MY_RPC_URL=https:://eth-mainnet.g.alchemy.com/v2/(YOUR_API_KEY_HERE)
```


### Lesson 1

Run Command: forge test -vvv --fork-url $MY_RPC_URL --fork-block-number 15725067 --match ^testStax
### Lesson 2

Run Command: forge test -vvv --fork-url $MY_RPC_URL --fork-block-number 13848982 --match ^testVisr