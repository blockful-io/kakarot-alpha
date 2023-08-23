// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract SelfDestruct {
    function useSelfdestruct(address payable _address) public {
        selfdestruct(_address);
    }

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

interface ITypes {
    function unsigned() external pure returns (uint);

    function unsigned256() external pure returns (uint256);

    function unsigned128() external pure returns (uint128);

    function unsigned64() external pure returns (uint64);

    function unsigned32() external pure returns (uint32);

    function unsigned16() external pure returns (uint16);

    function unsigned8() external pure returns (uint8);

    function contractName() external pure returns (string memory);

    function contractInterface() external pure returns (bytes4);
}

error InvalidValueForMinimum(uint256 _value);

contract Types is ITypes {
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
