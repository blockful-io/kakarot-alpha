// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Address} from "src/Address.sol";

contract AddressScript is Script {
    Address public ADDR;

    function setUp() public {
        ADDR = new Address();
    }

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("EVM_PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        testAddress();

        vm.stopBroadcast();
    }

    function testAddress() public {
        bool response;

        // fund for testing purposes
        (bool sent, ) = address(ADDR).call{value: 0.001 ether}("");
        assert(sent);

        response = ADDR.isContract(address(this));
        require(response, "Address.isContract should return true");

        uint256 balance = ADDR.getBalance();
        require(
            balance == address(ADDR).balance,
            "Address.getBalance should match"
        );

        bytes memory code = ADDR.getCode();
        require(
            keccak256(code) == keccak256(address(ADDR).code),
            "Address.getCode should match"
        );

        bytes32 codehash = ADDR.getCodehash();
        require(
            codehash == address(ADDR).codehash,
            "Address.getCodehash should match"
        );

        response = ADDR.sendEther{value: 0.001 ether}();
        require(response, "Address.sendEther should return true");

        ADDR.transferEther(address(this));
        require(
            ADDR.getBalance() == 0,
            "Address.transferEther should drain the contract"
        );
        require(
            address(ADDR).balance == 0,
            "Address.transferEther should drain the contract"
        );
    }

    receive() external payable {}
}
