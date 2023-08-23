// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Revert} from "src/Fallback.sol";
import {Require} from "src/Fallback.sol";
import {Context} from "src/Fallback.sol";
import {Call} from "src/Fallback.sol";
import {CallReceiver} from "src/Fallback.sol";

contract FallbackScript is Script {
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

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("EVM_PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        // testPlainEtherTransfer();
        // testContextOnFallback();
        testCallFromFallback();

        vm.stopBroadcast();
    }

    function testPlainEtherTransfer() public {
        bool sent;

        (sent, ) = address(REVERT).call{value: 0.001 ether}("0x01");
        require(!sent, "Revert should not be sent");

        (sent, ) = address(REVERT).call{value: 0.001 ether}("");
        require(!sent, "Revert should not be sent");

        (sent, ) = address(REQUIRE).call{value: 0 ether}("0x01");
        require(!sent, "Revert should not be sent");

        (sent, ) = address(REQUIRE).call{value: 0.001 ether}("0x01");
        require(sent, "Revert should be sent1");

        (sent, ) = address(REQUIRE).call{value: 0 ether}("");
        require(!sent, "Revert should not be sent");

        (sent, ) = address(REQUIRE).call{value: 0.001 ether}("");
        require(sent, "Revert should be sent2");
    }

    function testContextOnFallback() public {
        bool sent;
        uint256 balance;

        (sent, ) = address(CONTEXT).call{value: 0.001 ether}("0x01");
        assert(sent == true);

        balance = CONTEXT.balance();
        assert(balance == 0.001 ether);

        (sent, ) = address(CONTEXT).call{value: 0.001 ether}("");
        assert(sent == true);

        balance = CONTEXT.balance();
        assert(balance == 0.001 ether);
    }

    function testCallFromFallback() public {
        bool sent;
        uint256 balanceBefore = address(RECEIVER).balance;

        (sent, ) = address(CALL).call{value: 0.001 ether}("");
        require(sent == true, "Call should be sent");
        require(
            address(RECEIVER).balance == 0.001 ether + balanceBefore,
            "Receiver balance should be 0.001 ether"
        );
    }
}
