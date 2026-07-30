# How many satoshis did this transaction pay for fee?: b71fb9ab7707407cc7265591e0c0d47d07afede654f91de1f63c0cb522914bcb
TXID="b71fb9ab7707407cc7265591e0c0d47d07afede654f91de1f63c0cb522914bcb"

tx=$(bitcoin-cli -signet getrawtransaction "$TXID" true)

input_sats=$(
  printf '%s\n' "$tx" |
    jq -r '.vin[] | "\(.txid) \(.vout)"' |
    while read -r prev_txid prev_vout; do
      bitcoin-cli -signet getrawtransaction "$prev_txid" true |
        jq -r --argjson n "$prev_vout" \
          '.vout[] | select(.n == $n) | (.value * 100000000 | round)'
    done |
    awk '{ total += $1 } END { print total }'
)

output_sats=$(
  printf '%s\n' "$tx" |
    jq '[.vout[] | (.value * 100000000 | round)] | add'
)

echo "$((input_sats - output_sats))"
