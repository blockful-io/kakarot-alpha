// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Revert {
    fallback() external payable {
        revert("reverted on fallback");
    }

    receive() external payable {
        revert("reverted on receive");
    }
}

contract Require {
    fallback() external payable {
        require(
            msg.value == 0.001 ether,
            "msg.value should be strictly equal to 0.001 eth on Fallback"
        );
    }

    receive() external payable {
        require(
            msg.value == 0.001 ether,
            "msg.value should be strictly equal to 0.001 eth on Receive"
        );
    }
}

contract Context {
    uint256 public balance;
    bytes public data;

    fallback() external payable {
        balance = msg.value;
        data = msg.data;
    }

    receive() external payable {
        balance = msg.value;
    }
}

contract Call {
    address public RECEIVER;

    constructor(address _receiver) {
        RECEIVER = _receiver;
    }

    fallback() external payable {
        (bool sent, ) = RECEIVER.call{value: msg.value}("0x01");
        require(sent, "failed at Call");
    }

    receive() external payable {
        (bool sent, ) = RECEIVER.call{value: msg.value}("");
        require(sent, "failed at Call");
    }
}

contract CallReceiver {
    fallback() external payable {}

    receive() external payable {
        (bool sent, ) = (msg.sender).call{value: msg.value}("0x01");
        require(sent, "failed at CallReceiver");
    }
}
