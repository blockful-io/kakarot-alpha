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

        vm.stopBroadcast();
    }
}
