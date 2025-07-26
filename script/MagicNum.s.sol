// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import "../src/MagicNum.sol";

contract MagicNumScript is Script {

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
        MagicNum target;
        target = MagicNum(0x2539D383381b36ff70ed63E91AF57aff36909331);
        // bytecode : 68601a5f5260205ff35f5260086018f3
        target.setSolver(0x4A0fd3dd087671AE4d6b196306c6Fcc187B71983);
    }

}
