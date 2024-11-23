# How many new outputs were created by block 123,456?
bitcoin-cli getblock $(bitcoin-cli -rpcconnect=84.247.182.145 -rpcuser=user_064 -rpcpassword=UW1wGiCeFZRU getblockhash 123456) 2 | jq '[.tx[].vout[]] | length'
