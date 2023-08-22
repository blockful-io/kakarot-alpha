// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {SelfDescruct, Mod, Hashing, Types, ITypes} from "src/CheatSheet.sol";

contract CheatSheetScript is Script {
    Hashing public HASH;
    Types public TYPES;
    Mod public MOD;
    SelfDescruct public SELF;

    function setUp() public {
        HASH = new Hashing();
        TYPES = new Types();
        MOD = new Mod();
        SELF = new SelfDescruct();
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
        address payable addressToDestroy = payable(address(SELF));
        assert(addressToDestroy.balance == 0);

        uint256 value = 0.1 ether;
        (bool sent, ) = addressToDestroy.call{value: value}("");
        require(sent, "failed to send Ether");

        uint256 balanceBefore = address(this).balance;
        uint256 balanceAfter;

        SELF.useSelfdestruct(payable(address(this)));

        balanceAfter = address(this).balance;
        require(balanceAfter == balanceBefore + value, "balance differs");
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
        assert(creationCode.length > 0);

        bytes memory runtimeCode = type(Types).runtimeCode;
        assert(runtimeCode.length > 0);
    }

    function testContractName() public view {
        string memory name = TYPES.contractName();
        string memory expected = "Types";
        require(keccak256(abi.encode(name)) == keccak256(abi.encode(expected)));
    }

    function testContractInterface() public view {
        bytes4 interfaceId = TYPES.contractInterface();
        assert(interfaceId == type(ITypes).interfaceId);
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

        address signer = HASH.useEcrecover(_hash, v, r, s);
        require(
            signer == vm.addr(deployerPrivateKey),
            "Invalid signer from ecrecover"
        );
    }

    function testUnsignedIntegers() public view {
        uint unsigned = TYPES.unsigned();
        assert(unsigned == type(uint).max);

        uint256 unsigned256 = TYPES.unsigned256();
        assert(unsigned256 == type(uint256).max);

        uint128 unsigned128 = TYPES.unsigned128();
        assert(unsigned128 == type(uint128).max);

        uint64 unsigned64 = TYPES.unsigned64();
        assert(unsigned64 == type(uint64).max);

        uint32 unsigned32 = TYPES.unsigned32();
        assert(unsigned32 == type(uint32).max);

        uint16 unsigned16 = TYPES.unsigned16();
        assert(unsigned16 == type(uint16).max);

        uint8 unsigned8 = TYPES.unsigned8();
        assert(unsigned8 == type(uint8).max);
    }
}
