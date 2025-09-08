// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import "../src/DoubleEntryPoint.sol";

contract DoubleEntryPointScript is Script {
    Forta forta;
    CryptoVault vault;
    DoubleEntryPoint target;
    function setUp() public {
        target = DoubleEntryPoint(0xdfb61b32699bcDFF0093f8c30CF7a933eE8d0708);
        forta = target.forta();
        vault = CryptoVault(target.cryptoVault());
    }

    function run() public {
        vm.startBroadcast();

        Attack a = new Attack(forta);
        forta.setDetectionBot(address(a));

        vm.stopBroadcast();
    }

    function handleTransaction(address user, bytes calldata msgData) external {
          forta.raiseAlert(user);
    }
}

contract Attack {

    Forta forta;
    constructor(Forta forta_) {
        forta = forta_;
    }

    function handleTransaction(address user, bytes calldata msgData) external {
          forta.raiseAlert(user);
    }
}