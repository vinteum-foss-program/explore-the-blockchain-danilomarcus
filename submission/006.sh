# Which tx in block 257,343 spends the coinbase output of block 256,128?
coinbasetx=$(bitcoin-cli -rpcconnect=84.247.182.145 -rpcuser=user_064 -rpcpassword=UW1wGiCeFZRU getblock $(bitcoin-cli -rpcconnect=84.247.182.145 -rpcuser=user_064 -rpcpassword=UW1wGiCeFZRU getblockhash 256128) | jq -r ".tx[0]")

txs=$(bitcoin-cli -rpcconnect=84.247.182.145 -rpcuser=user_064 -rpcpassword=UW1wGiCeFZRU getblock $(bitcoin-cli -rpcconnect=84.247.182.145 -rpcuser=user_064 -rpcpassword=UW1wGiCeFZRU getblockhash 257343) | jq -r ".tx[]")

for TX in $txs; do
	RAW_TX=$(bitcoin-cli -rpcconnect=84.247.182.145 -rpcuser=user_064 -rpcpassword=UW1wGiCeFZRU decoderawtransaction $(bitcoin-cli -rpcconnect=84.247.182.145 -rpcuser=user_064 -rpcpassword=UW1wGiCeFZRU getrawtransaction $TX))
	
	SPENT_TX=$(echo $RAW_TX | jq --arg CBTX "$coinbasetx" '.vin[] | select(.txid == $CBTX)')
	
	if [ -n "$SPENT_TX" ]; then
		echo "$TX"
		break
	fi
done
