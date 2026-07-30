# Which tx in block 216,351 spends the coinbase output of block 216,128?
COINBASE_TXID=$(
  bitcoin-cli -signet -rpcuser=btrustbuildersrpc -rpcpassword=btrustbuilderspass -rpcconnect=167.172.185.136 getblock "$(
      bitcoin-cli -signet -rpcuser=btrustbuildersrpc -rpcpassword=btrustbuilderspass -rpcconnect=167.172.185.136 getblockhash 216128
    )" 1 |
  jq -r '.tx[0]'
)

bitcoin-cli -signet -rpcuser=btrustbuildersrpc -rpcpassword=btrustbuilderspass -rpcconnect=167.172.185.136 getblock "$(
    bitcoin-cli -signet -rpcuser=btrustbuildersrpc -rpcpassword=btrustbuilderspass -rpcconnect=167.172.185.136 getblockhash 216351
  )" 2 |
jq -r --arg coinbase "$COINBASE_TXID" \
  '.tx[] | select(any(.vin[]; .txid == $coinbase)) | .txid'