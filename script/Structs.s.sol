// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Structs} from "src/Structs.sol";

contract CheatSheetScript is Script {
    Structs public STRUCTS;

    function setUp() public {
        STRUCTS = new Structs();
    }

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("EVM_PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        testStructAndMapping();

        vm.stopBroadcast();
    }

    function testStructAndMapping() public {
        STRUCTS.setEasy();
        require(STRUCTS.getEasy() == 1, "getEasy() should return 1");

        STRUCTS.setSimple();
        (uint256 a, uint256 b) = STRUCTS.getSimple(0);
        require(a == 7, "getSimple(0) should return 7");
        require(b == 42, "getSimple(0) should return 99");
        (, b) = STRUCTS.getSimple(1);
        require(b == 99, "getSimple(0) should return 42");

        STRUCTS.setComplex();
        (a, b) = STRUCTS.getComplex(0);
        require(a == 101, "getSimple(0) should return 101");
        require(b == 102, "getSimple(0) should return 102");
        (, b) = STRUCTS.getComplex(1);
        require(b == 103, "getSimple(0) should return 103");
    }
}
