// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.15;
import "solecs/BoolComponent.sol";

struct Health {
  int32 current;
  int32 max;
}

uint256 constant ID = uint256(keccak256("graal.component.Captureable"));

contract CaptureableComponent is BoolComponent {
  constructor(address world) BoolComponent(world, ID) {}
}
