// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {Revert} from "src/Fallback.sol";
import {Require} from "src/Fallback.sol";
import {Context} from "src/Fallback.sol";
import {Call} from "src/Fallback.sol";
import {CallReceiver} from "src/Fallback.sol";

contract FallbackTest is Test {
    Revert public REVERT;
    Require public REQUIRE;
    Context public CONTEXT;
    Call public CALL;
    CallReceiver public RECEIVER;

    function setUp() public {
        REVERT = new Revert();
        REQUIRE = new Require();
        CONTEXT = new Context();
        RECEIVER = new CallReceiver();
        CALL = new Call(address(RECEIVER));
    }

    function testPlainEtherTransfer() public {
        bool sent;

        (sent, ) = address(REVERT).call{value: 0.1 ether}("0x01");
        assertEq(sent, false);

        (sent, ) = address(REVERT).call{value: 0.1 ether}("");
        assertEq(sent, false);

        (sent, ) = address(REQUIRE).call{value: 0 ether}("0x01");
        assertEq(sent, false);

        (sent, ) = address(REQUIRE).call{value: 0.1 ether}("0x01");
        assertEq(sent, true);

        (sent, ) = address(REQUIRE).call{value: 0 ether}("");
        assertEq(sent, false);

        (sent, ) = address(REQUIRE).call{value: 0.1 ether}("");
        assertEq(sent, true);
    }

    function testContextOnFallback() public {
        bool sent;
        uint256 balance;
        bytes memory data;

        (sent, ) = address(CONTEXT).call{value: 0.1 ether}("0x01");
        assertEq(sent, true);

        balance = CONTEXT.balance();
        assertEq(balance, 0.1 ether);

        data = CONTEXT.data();
        assertEq(data, "0x01");

        (sent, ) = address(CONTEXT).call{value: 0.1 ether}("");
        assertEq(sent, true);

        balance = CONTEXT.balance();
        assertEq(balance, 0.1 ether);
    }

    function testCallFromFallback() public {
        bool sent;

        (sent, ) = address(CALL).call{value: 0.1 ether}("");
        assertEq(sent, true);
        assertEq(address(CALL).balance, 0 ether);
        assertEq(address(RECEIVER).balance, 0.1 ether);
    }
}
