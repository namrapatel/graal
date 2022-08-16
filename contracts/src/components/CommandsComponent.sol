// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.15;
import "../base/StringArrayComponent.sol";

uint256 constant ID = uint256(keccak256("graal.component.Commands"));

contract CommandsComponent is StringArrayComponent {
  constructor(address world) StringArrayComponent(world, ID) {}
}
