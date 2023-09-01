// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract AbiEncoding {
    bytes public result;

    function simpleEncode() public returns (bytes memory) {
        return result = abi.encode(1, 2, 3);
    }

    function normalEncode() public returns (bytes memory) {
        return
            result = abi.encode(
                "Blockful",
                ["Test1", "Test2"],
                3,
                block.timestamp
            );
    }

    struct Complex {
        uint256 a;
        address b;
    }

    function complexEncode() public returns (bytes memory) {
        Complex memory res = Complex(type(uint256).max, address(this));
        return
            result = abi.encode(
                res,
                keccak256(abi.encode(keccak256(abi.encode(res))))
            );
    }

    // currently not compiling in remix (max: 13), but foundry is not giving
    // any error due to optimizer so will be useful to test on kakarot later (v.0.8.13)
    function stressEncode() public returns (bytes memory) {
        Complex memory res = Complex(type(uint256).max, address(this));
        // More will trigger stack-too-deep with regular optimizer runs (max:14)
        return
            result = abi.encode(
                res,
                res,
                res,
                block.timestamp,
                res,
                address(this),
                1,
                2,
                3,
                "Blockful",
                this.stressEncode.selector,
                4,
                5,
                address(this).code
            );
    }

    function simpleEncodePacked(
        uint256 a,
        uint256 b,
        uint256 c
    ) public returns (bytes memory) {
        return result = abi.encodePacked(a, b, c);
    }

    function normalEncodePacked(
        string memory name,
        uint256 a
    ) public returns (bytes memory) {
        return
            result = abi.encodePacked(
                name,
                a,
                this.normalEncodePacked.selector,
                address(this).code,
                block.timestamp
            );
    }

    function stressComplexEncodePacked(
        address target
    ) public returns (bytes memory) {
        // Structs are not supported in abi.encodePacked, neither arrays
        // We'll stress with substacks and intermixing contract calls
        return
            result = abi.encodePacked(
                keccak256(
                    abi.encodePacked(
                        keccak256(
                            abi.encodePacked(
                                StressAbiEncoding(target).stressBack(target)
                            )
                        )
                    )
                )
            );
    }
}

contract StressAbiEncoding {
    function stressBack(address target) public returns (bytes memory) {
        return
            abi.encode(
                AbiEncoding(target).stressComplexEncodePacked(target),
                2,
                3,
                4,
                5,
                6,
                7
            );
    }
}

contract Concat {
    string public resultString;
    bytes public resultBytes;

    function concat() public returns (string memory) {
        return
            resultString = string.concat("Blockful", " ", "is", " ", "awesome");
    }

    function concatBytes() public returns (bytes memory) {
        return
            resultBytes = bytes.concat("Blockful", " ", "is", " ", "awesome");
    }
}
