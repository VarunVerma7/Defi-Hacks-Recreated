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

Use --match flag to run a specific test, so for example, lesson 1 do 

`forge test -vvv --fork-url $MY_RPC_URL --match ^testStax`

and for lesson 2 do

`forge test -vvv --fork-url $MY_RPC_URL --match ^testVisr`

etc.
