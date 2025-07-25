from web3 import Web3
import os

PK = os.environ["PK"]
ADDR = os.environ["ETH_ADDR"]
SEPOLIA_RPC = os.environ["SEPOLIA"]

target_address = "0x53d46C471116dDA1611f260F10B5a23fAf1655f4"
w3 = Web3(Web3.HTTPProvider(SEPOLIA_RPC))

if w3.is_connected():
    print("RPC is connected")
    for i in range(0, 10):
        print(f"{i} slot : {w3.eth.get_storage_at(target_address, i).hex()}")
else:
    print("RPC Error")