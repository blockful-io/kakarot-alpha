// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {SelfDestruct, Mod, Hashing, Types, ITypes} from "src/CheatSheet.sol";

contract CheatSheetScript is Script {
    Hashing public HASH;
    Types public TYPES;
    Mod public MOD;
    SelfDestruct public DESTRUCT;

    function setUp() public {
        HASH = new Hashing();
        TYPES = new Types();
        MOD = new Mod();
        DESTRUCT = new SelfDestruct();
    }

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("EVM_PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        testSelfDestruct();
        testMod();
        testCreationAndRuntimeCode();
        testContractName();
        testContractInterface();
        testHashing();
        testUnsignedIntegers();

        vm.stopBroadcast();
    }

    function testSelfDestruct() public {
        uint256 currbalance = address(DESTRUCT).balance;

        uint256 value = 0.001 ether;
        (bool sent, ) = payable(address(DESTRUCT)).call{value: value}("");
        require(sent, "failed to send Ether");

        uint256 balanceBefore = address(this).balance;
        DESTRUCT.useSelfdestruct(payable(address(this)));
        uint256 balanceAfter = address(this).balance;

        require(
            balanceAfter == balanceBefore + value + currbalance,
            "balance differs"
        );
    }

    function testMod() public view {
        uint256 response;

        response = MOD.useAddmod(4, 3, 3);
        require(response == addmod(4, 3, 3), "addmod differs");

        response = MOD.useMulmod(4, 3, 3);
        require(response == mulmod(4, 3, 3), "mulmod differs");
    }

    function testCreationAndRuntimeCode() public pure {
        bytes memory creationCode = type(Types).creationCode;
        require(creationCode.length > 0, "creationCode is empty");

        bytes memory runtimeCode = type(Types).runtimeCode;
        require(runtimeCode.length > 0, "runtimeCode is empty");
    }

    function testContractName() public view {
        string memory name = TYPES.contractName();
        string memory expected = "Types";
        require(
            keccak256(abi.encode(name)) == keccak256(abi.encode(expected)),
            "Invalid contract name"
        );
    }

    function testContractInterface() public view {
        bytes4 interfaceId = TYPES.contractInterface();
        require(interfaceId == type(ITypes).interfaceId, "Invalid interfaceId");
    }

    function testHashing() public view {
        uint256 deployerPrivateKey = vm.envUint("EVM_PRIVATE_KEY");
        bytes memory name = "Blockful";

        bytes32 response;

        response = HASH.useKeccak256(name);
        require(response == keccak256(name), "Invalid keccak256 hash");

        response = HASH.useSha256(name);
        require(response == sha256(name), "Invalid sha256 hash");

        response = HASH.useRipemd160(name);
        require(response == ripemd160(name), "Invalid ripemd160 hash");

        bytes32 _hash = keccak256(name);
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(deployerPrivateKey, _hash);

        string memory _name = "Blockful";
        bytes memory _nameBytes = abi.encodePacked(_name);
        bytes32 __hash = keccak256(_nameBytes);
        (v, r, s) = vm.sign(deployerPrivateKey, __hash);
        console.log(vm.addr(deployerPrivateKey));
        console.log("v", v);
        console.logBytes32(r);
        console.logBytes32(s);

        address signer = HASH.useEcrecover(_hash, v, r, s);
        require(
            signer == vm.addr(deployerPrivateKey),
            "Invalid signer from ecrecover"
        );
    }

    function testUnsignedIntegers() public view {
        uint unsigned = TYPES.unsigned();
        require(unsigned == type(uint).max, "Invalid unsigned");

        uint256 unsigned256 = TYPES.unsigned256();
        require(unsigned256 == type(uint256).max, "Invalid unsigned256");

        uint128 unsigned128 = TYPES.unsigned128();
        require(unsigned128 == type(uint128).max, "Invalid unsigned128");

        uint64 unsigned64 = TYPES.unsigned64();
        require(unsigned64 == type(uint64).max, "Invalid unsigned64");

        uint32 unsigned32 = TYPES.unsigned32();
        require(unsigned32 == type(uint32).max, "Invalid unsigned32");

        uint16 unsigned16 = TYPES.unsigned16();
        require(unsigned16 == type(uint16).max, "Invalid unsigned16");

        uint8 unsigned8 = TYPES.unsigned8();
        require(unsigned8 == type(uint8).max, "Invalid unsigned8");
    }
}
