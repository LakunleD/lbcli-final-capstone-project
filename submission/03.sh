# Which tx in block 216,351 spends the coinbase output of block 216,128?
COINBASE_TXID=$(
  bitcoin-cli -signet getblock "$(
      bitcoin-cli -signet getblockhash 216128
    )" 1 |
  jq -r '.tx[0]'
)

bitcoin-cli -signet getblock "$(
    bitcoin-cli -signet getblockhash 216351
  )" 2 |
jq -r --arg coinbase "$COINBASE_TXID" \
  '.tx[] | select(any(.vin[]; .txid == $coinbase)) | .txid'