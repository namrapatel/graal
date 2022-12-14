// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.15;
import "solecs/Component.sol";
import "std-contracts/components/Uint256ArrayComponent.sol";

uint256 constant ID = uint256(keccak256("graal.component.Prototype"));

contract PrototypeComponent is Uint256ArrayComponent {
  constructor(address world) Uint256ArrayComponent(world, ID) {}
}
