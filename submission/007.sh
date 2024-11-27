# Only one single output remains unspent from block 123,321. What address was it sent to?
txs=$(bitcoin-cli getblock $(bitcoin-cli getblockhash 123321) | jq -r ".tx[]")

for TX in $txs; do	
	vout=$(bitcoin-cli decoderawtransaction $(bitcoin-cli getrawtransaction $TX) | jq ".vout")
	
	i=0
	len=$(echo "$vout" | jq 'length')
	
	while [ $i -lt $len ]; do
		UNSPENT=$(bitcoin-cli gettxout $TX $i)
		if [ -n "$UNSPENT" ]; then
			echo "$UNSPENT" | jq -r ".scriptPubKey.address"
			break 2
		fi
		((i++))
	done
done
