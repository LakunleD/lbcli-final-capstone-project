# How many new outputs were created by block 243,825?
bitcoin-cli -signet \
  getblock "$(
    bitcoin-cli -signet \
      getblockhash 243835
  )" 2 |
jq '[.tx[].vout | length] | add'