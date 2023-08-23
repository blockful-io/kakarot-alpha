// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {ControlStructureTest} from "src/Counter.sol";

contract CheatSheetScript is Script {
    ControlStructureTest public COUNTER;

    function setUp() public {
        COUNTER = new ControlStructureTest();
    }

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("EVM_PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        testCounterWith10Interactions();
        testCounterWith100Interactions();
        testCounterWith5000Interactions();
        // testCounterWith50000Interactions();

        vm.stopBroadcast();
    }

    function testCounterWith10Interactions() public {
        uint256 iterations = 10;
        COUNTER.testForLoop(iterations);
        require(COUNTER.count() == iterations, "for loop failed");

        COUNTER.testWhileLoop(iterations);
        require(COUNTER.count() == iterations, "while loop failed");
    }

    function testCounterWith100Interactions() public {
        uint256 iterations = 100;
        COUNTER.testForLoop(iterations);
        require(COUNTER.count() == iterations, "for loop failed");

        COUNTER.testWhileLoop(iterations);
        require(COUNTER.count() == iterations, "while loop failed");
    }

    function testCounterWith5000Interactions() public {
        uint256 iterations = 5000;
        COUNTER.testForLoop(iterations);
        require(COUNTER.count() == iterations, "for loop failed");

        COUNTER.testWhileLoop(iterations);
        require(COUNTER.count() == iterations, "while loop failed");
    }

    function testCounterWith50000Interactions() public {
        uint256 iterations = 50000;

        COUNTER.testForLoop(iterations);
        require(COUNTER.count() == iterations, "for loop failed");

        COUNTER.testWhileLoop(iterations);
        require(COUNTER.count() == iterations, "while loop failed");

        console.log("COUNTER.count()", COUNTER.count());
    }
}
