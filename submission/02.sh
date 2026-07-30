# How many new outputs were created by block 243,825?
bitcoin-cli -signet -rpcuser=btrustbuildersrpc -rpcpassword=btrustbuilderspass -rpcconnect=167.172.185.136 \
  getblock "$(
    bitcoin-cli -signet -rpcuser=btrustbuildersrpc -rpcpassword=btrustbuilderspass -rpcconnect=167.172.185.136 \
      getblockhash 243825
  )" 2 |
jq '[.tx[].vout | length] | add'