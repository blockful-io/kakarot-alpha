// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Structs {
    mapping(uint256 => mapping(uint256 => mapping(uint256 => mapping(uint256 => mapping(uint256 => mapping(uint256 => uint256))))))
        public a;
    mapping(uint256 => mapping(uint256 => mapping(uint256 => mapping(uint256 => mapping(uint256 => mapping(uint256 => Simple))))))
        public b;
    mapping(uint256 => mapping(uint256 => mapping(uint256 => mapping(uint256 => mapping(uint256 => mapping(uint256 => Complex)))))) c;

    struct Simple {
        uint256 a;
        mapping(uint256 => uint256) b;
    }

    struct Complex {
        mapping(uint256 => mapping(uint256 => mapping(uint256 => mapping(uint256 => mapping(uint256 => mapping(uint256 => Simple)))))) e;
    }

    function setComplex() public {
        Complex storage s = c[0][0][0][0][0][0];
        s.e[0][0][0][0][0][0].a = 101;
        s.e[0][0][0][0][0][0].b[0] = 102;
        s.e[0][0][0][0][0][0].b[1] = 103;
    }

    function getComplex(uint256 _id) public view returns (uint256, uint256) {
        Complex storage s = c[0][0][0][0][0][0];
        return (s.e[0][0][0][0][0][0].a, s.e[0][0][0][0][0][0].b[_id]);
    }

    function setSimple() public {
        Simple storage s = b[0][0][0][0][0][0];
        s.a = 7;
        s.b[0] = 42;
        s.b[1] = 99;
    }

    function getSimple(uint256 _id) public view returns (uint256, uint256) {
        Simple storage s = b[0][0][0][0][0][0];
        return (s.a, s.b[_id]);
    }

    function getEasy() public view returns (uint256) {
        return a[0][0][0][0][0][0];
    }

    function setEasy() public {
        a[0][0][0][0][0][0] = 1;
    }
}
