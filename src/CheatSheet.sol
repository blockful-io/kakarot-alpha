// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

// Fail on Remix
// https://github.com/kkrt-labs/kakarot/issues/690
contract OuroborosDestruct {
    fallback() external payable {
        selfdestruct(payable(address(this)));
    }

    receive() external payable {
        address(this).call{value: 0}("0x01");
    }
}

// Fail on Remix
// https://github.com/kkrt-labs/kakarot/issues/689
contract SelfDestruct {
    function useSelfdestruct(address payable _address) public {
        selfdestruct(_address);
    }

    receive() external payable {}
}

contract Receiver {
    receive() external payable {}
}

contract Mod {
    function useAddmod(uint x, uint y, uint k) public pure returns (uint) {
        return addmod(x, y, k);
    }

    function useMulmod(uint x, uint y, uint k) public pure returns (uint) {
        return mulmod(x, y, k);
    }
}

// Fail on Remix
// https://github.com/kkrt-labs/kakarot/issues/691
contract ModMax {
    function testAddmod() public pure returns (uint) {
        return addmod(type(uint256).max, type(uint256).max, type(uint256).max);
    }

    function testMulmod() public pure returns (uint) {
        return mulmod(type(uint256).max, type(uint256).max, type(uint256).max);
    }
}

contract Hashing {
    function useKeccak256(bytes memory _hex) public pure returns (bytes32) {
        return keccak256(_hex);
    }

    function useSha256(bytes memory _hex) public pure returns (bytes32) {
        return sha256(_hex);
    }

    function useRipemd160(bytes memory _hex) public pure returns (bytes32) {
        return ripemd160(_hex);
    }

    function useEcrecover(
        bytes32 _hash,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) public pure returns (address) {
        return ecrecover(_hash, v, r, s);
    }
}

// Fail on Remix
// https://github.com/kkrt-labs/kakarot/issues/692
contract HashingForRemix {
    function useKeccak256() public pure returns (bytes32) {
        string memory name = "Blockful";
        bytes memory encodedName = abi.encodePacked(name);
        return keccak256(encodedName);
    }

    function useSha256() public pure returns (bytes32) {
        string memory name = "Blockful";
        bytes memory encodedName = abi.encodePacked(name);
        return sha256(encodedName);
    }

    function useRipemd160() public pure returns (bytes32) {
        string memory name = "Blockful";
        bytes memory encodedName = abi.encodePacked(name);
        return ripemd160(encodedName);
    }

    // signer pkey 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
    // v 27
    // r 0xe56beeb0661820111478c4b6f0435e5e1ee811676153432412b96e5e15056ee4
    // s 0x55b75850e86c0b2a4a56f39ea1f560d6a30517bea27b73b7f537b56cffba3563
    function useEcrecover(
        uint8 v,
        bytes32 r,
        bytes32 s
    ) public pure returns (address) {
        return ecrecover(useKeccak256(), v, r, s);
    }
}

error InvalidValueForMinimum(uint256 _value);

contract Types {
    function unsigned() public pure returns (uint) {
        if (type(uint).min != 0) {
            revert InvalidValueForMinimum(type(uint).min);
        }
        return type(uint).max;
    }

    function unsigned256() public pure returns (uint256) {
        if (type(uint256).min != 0) {
            revert InvalidValueForMinimum(type(uint256).min);
        }
        return type(uint256).max;
    }

    function unsigned128() public pure returns (uint128) {
        if (type(uint128).min != 0) {
            revert InvalidValueForMinimum(type(uint128).min);
        }
        return type(uint128).max;
    }

    function unsigned64() public pure returns (uint64) {
        if (type(uint64).min != 0) {
            revert InvalidValueForMinimum(type(uint64).min);
        }
        return type(uint64).max;
    }

    function unsigned32() public pure returns (uint32) {
        if (type(uint32).min != 0) {
            revert InvalidValueForMinimum(type(uint32).min);
        }
        return type(uint32).max;
    }

    function unsigned16() public pure returns (uint16) {
        if (type(uint16).min != 0) {
            revert InvalidValueForMinimum(type(uint16).min);
        }
        return type(uint16).max;
    }

    function unsigned8() public pure returns (uint8) {
        if (type(uint8).min != 0) {
            revert InvalidValueForMinimum(type(uint8).min);
        }
        return type(uint8).max;
    }

    function contractName() public pure returns (string memory) {
        return type(Types).name;
    }

    function contractInterface() public pure returns (bytes4) {
        return type(ITypes).interfaceId;
    }
}
