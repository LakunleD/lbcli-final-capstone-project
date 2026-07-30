# Only one tx in block 243,821 signals opt-in RBF. What is its txid?
BLOCK=$(bitcoin-cli -signet getblockhash 243821)

bitcoin-cli -signet getblock "$BLOCK" 2 | jq -r '
  .tx[]
  | select(any(.vin[]; has("sequence") and .sequence < 4294967294))
  | .txid
'