// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "forge-std/Script.sol";
import {Create2} from "../src/Create2.sol";


contract Create2Deploy is Script {

    Create2 create2;

    function run() external {

        // Anything within the broadcast cheatcodes is executed on-chain
        vm.startBroadcast();

        // Deploy the Create2 contract
        create2 = new Create2();

        bytes32 salt = "12345";
        bytes memory bytecode = abi.encodePacked(vm.getCode("Create2.sol:Create2"));

        address deployedAddress = create2.deploy(0, salt , bytecode);
        console2.log("Address of Create2Factory: %s", deployedAddress);

        vm.stopBroadcast();
    }

}