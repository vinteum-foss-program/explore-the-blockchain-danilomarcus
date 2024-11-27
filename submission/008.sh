# Which public key signed input 0 in this tx:
#   `e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163`
bitcoin-cli decoderawtransaction $(bitcoin-cli getrawtransaction e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163) | jq ".vin[0]" | jq -r '.txinwitness[2]' | cut -c 5-70
