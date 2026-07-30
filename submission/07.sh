# what is the coinbase tx in this block 243,834
bitcoin-cli -signet -rpcuser=btrustbuildersrpc -rpcpassword=btrustbuilderspass -rpcconnect=167.172.185.136 getblock \
 $(bitcoin-cli -signet -rpcuser=btrustbuildersrpc -rpcpassword=btrustbuilderspass -rpcconnect=167.172.185.136 getblockhash 243834) 1 | jq -r '.tx[0]'