# Minimal Kakarot Tester

All tests will be runned in this file, which is the minimal Foundry version. The RPC for Kakarot must be started from the repository kakarot-rpc. Anvil must be started from this repo: kakarot-alpha.

All the opcodes and other cheatcodes for Solidity: https://docs.soliditylang.org/en/v0.8.13/cheatsheet.html

Compiler version is 0.8.13

## Test Status

C = community is working on

#### [ ] Yul

#### [ ] Delegate Call Methods

#### [ ] Chainned Contract Calls

#### [ ] ABI Decode

#### [ ] ABI Encode Call

#### [ ] ABI EncodeWithSelector

#### [ ] ABI EncodeWithSignature

#### [ ] Super

#### [ ] Assembly

#### [ ] Unchecked

#### [C] Bitwise & Assignment Operators

#### [C] Constructor

#### [C] Modifiers

#### [X] Inifite loops;

#### [X] Handling `msg.value` and `msg.data`;

#### [X] ABI Encode

#### [X] ABI EncodePacked

#### [X] Concat (string, bytes)

#### [X] Type(T,I,C)...

#### [X] Type Casts Min, Max

#### [X] Sender, Data, Value, Sig, Origin

#### [X] Address lib

#### [X] Address, Transfer, Send, Code, Balance

#### [X] Mulmod, Addmod

#### [X] Hashings, keccak, ripemd, sha, ecrecover

#### [X] Assertion, Require, Revert

#### [X] Fallback, Receive

#### [X] Self Destruct

#### [X] Structs, Mappings

#### [X] Stack-too-deep

## Documentation

### Installation and instancing RPC

https://kakarotlabs.notion.site/Run-Kakarot-Locally-using-Docker-33d3b0b12be641eea563b4fb8eb3d33e

## Other libs

Added to `foundry.toml` as remappings.

### Openzeppelin

```shell
$ forge install @openzeppelin/contracts
```

### Official GitHub repo

https://github.com/kkrt-labs

## Usage

### Katana RPC

Must have Docker and kakarot-rpc repository installed.

```shell
$ make katana-rpc-up
```

### Anvil RPC

In this repository (kakarot-alpha) main folder start Anvil with

```shell
$ anvil
```

to make all the anvil tests, then compare with katana's.

### Run Makefile

You can opt to run the Makefile scripts to test it all at once:

1. Start Anvil node
2. Start Katana rpc
3. Run the bellow command

```shell
$ make all
```

This will test all currently available script files in both anvil and katana

### Run scripts

Change the <SCRIPTNAME> for the one to be executed. Some tests are really extensive when using verbosity at the maximum.

For Anvil use http://localhost:8545

```shell
$ forge script script/<SCRIPTNAME>.s.sol --legacy --compute-units-per-second 4000 --slow --fork-url http://localhost:8545 -vvvvv

```

For Katana use http://localhost:3030

```shell
$ forge script script/<SCRIPTNAME>.s.sol --legacy --compute-units-per-second 4000 --slow --fork-url http://localhost:3030 -vvvvv

```

### Run tests functions

This is stopped being developed due to the tests in foundry not responding well to the rpc

Anvil

```shell
$ forge test --fork-url http://localhost:8545 -vvvvv
```

Katana

```shell
$ forge test --fork-url http://localhost:3030 -vvvvv
```

## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

- **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
- **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
- **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
- **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```
