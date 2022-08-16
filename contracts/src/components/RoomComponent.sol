// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.15;
import "std-contracts/components/Uint32Component.sol";

uint256 constant ID = uint256(keccak256("graal.component.Room"));

contract RoomComponent is Uint32Component {
  constructor(address world) Uint32Component(world, ID) {}
}
