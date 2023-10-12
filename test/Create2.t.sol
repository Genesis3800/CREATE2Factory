// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {Create2} from "../src/Create2.sol";

contract Create2Test is Test {

    Create2 internal create2;

    uint256 internal sepoliaFork;
    string internal ALCHEMY_SEPOLIA_URL = vm.envString("ALCHEMY_SEPOLIA_URL");

    uint256 internal mumbaiFork;
    string internal ALCHEMY_MUMBAI_URL = vm.envString("ALCHEMY_MUMBAI_URL");

    function setUp() public {
    
        sepoliaFork = vm.createFork(ALCHEMY_SEPOLIA_URL);
        mumbaiFork = vm.createFork(ALCHEMY_MUMBAI_URL);
    }

    function testSepoliaDeploy() public {

        vm.selectFork(sepoliaFork);
        assertEq(vm.activeFork(), sepoliaFork);

        create2 = new Create2();

        vm.deal(address(0x1), 100 ether);
        vm.startPrank(address(0x1));
        
        bytes32 salt = "12345";
        bytes memory bytecode = abi.encodePacked(vm.getCode("Create2.sol:Create2"));

        address computedAddress = create2.computeAddress(salt, keccak256(bytecode));
        address deployedAddress = create2.deploy(0, salt , bytecode);
        vm.stopPrank();

        assertEq(computedAddress, deployedAddress);    
    }


    function testMumbaiDeploy() public {

        vm.selectFork(mumbaiFork);
        assertEq(vm.activeFork(), mumbaiFork);

        create2 = new Create2();

        vm.deal(address(0x1), 100 ether);
        vm.startPrank(address(0x1));

        bytes32 salt = "12345";
        bytes memory bytecode = abi.encodePacked(vm.getCode("Create2.sol:Create2"));

        address computedAddress = create2.computeAddress(salt, keccak256(bytecode));
        address deployedAddress = create2.deploy(0, salt , bytecode);
        vm.stopPrank();

        assertEq(computedAddress, deployedAddress);    
    }

}
