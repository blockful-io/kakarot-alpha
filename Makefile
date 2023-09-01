-include .env
export

all:
    make anvil
	make address-anvil
	make address-katana
	make cheatsheet-anvil
	make cheatsheet-katana
	make counter-anvil
	make counter-katana
	make fallback-anvil
	make fallback-katana
	make structs-anvil
	make structs-katana

address-anvil:
	forge script script/Address.s.sol --broadcast --legacy --compute-units-per-second 4000  --slow --fork-url http://localhost:8545

address-katana:
	forge script script/Address.s.sol --broadcast --legacy --compute-units-per-second 4000  --slow --fork-url http://localhost:3030

cheatsheet-anvil:
	forge script script/CheatSheet.s.sol --broadcast --legacy --compute-units-per-second 4000  --slow --fork-url http://localhost:8545

cheatsheet-katana:
	forge script script/CheatSheet.s.sol --broadcast --legacy --compute-units-per-second 4000  --slow --fork-url http://localhost:3030

counter-anvil:
	forge script script/Counter.s.sol --broadcast --legacy --compute-units-per-second 4000  --slow --fork-url http://localhost:8545

counter-katana:
	forge script script/Counter.s.sol --broadcast --legacy --compute-units-per-second 4000  --slow --fork-url http://localhost:3030

fallback-anvil:
	forge script script/Fallback.s.sol --broadcast --legacy --compute-units-per-second 4000  --slow --fork-url http://localhost:8545

fallback-katana:
	forge script script/Fallback.s.sol --broadcast --legacy --compute-units-per-second 4000  --slow --fork-url http://localhost:3030

structs-anvil:
	forge script script/Structs.s.sol --broadcast --legacy --compute-units-per-second 4000  --slow --fork-url http://localhost:8545

structs-katana:
	forge script script/Structs.s.sol --broadcast --legacy --compute-units-per-second 4000  --slow --fork-url http://localhost:3030