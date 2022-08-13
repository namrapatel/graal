// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.15;
import "std-contracts/components/StringComponent.sol";

uint256 constant ID = uint256(keccak256("graal.component.RoomName"));

contract RoomNameComponent is StringComponent {
  constructor(address world) StringComponent(world, ID) {}
}
