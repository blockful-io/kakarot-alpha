// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ControlStructureTest {
    uint256 public count = 0;

    function testForLoop(uint256 iterations) public {
        count = 0;
        for (uint256 i = 0; i < iterations; i++) {
            count++;
        }
    }

    function testWhileLoop(uint256 iterations) public {
        count = 0;
        while (count < iterations) {
            count++;
        }
    }
}
