// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

interface IStructs {
    struct ISimple {
        uint256 a;
        uint256[] b;
    }
    struct IComplex {
        mapping(uint256 => mapping(uint256 => uint256)) a;
        mapping(uint256 => mapping(uint256 => mapping(uint256 => uint256))) b;
        mapping(uint256 => mapping(uint256 => mapping(uint256 => mapping(uint256 => uint256)))) c;
        mapping(uint256 => mapping(uint256 => mapping(uint256 => mapping(uint256 => mapping(uint256 => uint256))))) d;
    }
}

contract Structs is IStructs {
    mapping(uint256 => mapping(uint256 => mapping(uint256 => mapping(uint256 => mapping(uint256 => mapping(uint256 => Complex)))))) a;

    struct Simple {
        uint256 a;
        uint256[] b;
        mapping(uint256 => uint256) c;
    }
    struct Complex {
        mapping(uint256 => mapping(uint256 => uint256)) a;
        mapping(uint256 => mapping(uint256 => mapping(uint256 => uint256))) b;
        mapping(uint256 => mapping(uint256 => mapping(uint256 => mapping(uint256 => uint256)))) c;
        mapping(uint256 => mapping(uint256 => mapping(uint256 => mapping(uint256 => mapping(uint256 => uint256))))) d;
        mapping(uint256 => mapping(uint256 => mapping(uint256 => mapping(uint256 => mapping(uint256 => mapping(uint256 => Simple)))))) e;
    }
}
