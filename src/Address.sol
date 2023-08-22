// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Address {
    function isContract(address addr) public view returns (bool) {
        uint size;
        assembly {
            size := extcodesize(addr)
        }
        return size > 0;
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    event AddressCode(bytes indexed code);

    function getCode() public returns (bytes memory) {
        emit AddressCode(address(this).code);
        return address(this).code;
    }

    function getCodehash() public view returns (bytes32) {
        return address(this).codehash;
    }

    function sendEther() public payable returns (bool) {
        return payable(address(this)).send(msg.value);
    }

    function transferEther(address addr) public payable {
        payable(addr).transfer(address(this).balance);
    }

    receive() external payable {}
}
