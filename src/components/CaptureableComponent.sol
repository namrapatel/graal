// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.15;
import "std-contracts/components/BoolComponent.sol";

uint256 constant ID = uint256(keccak256("graal.component.Captureable"));

contract CaptureableComponent is BoolComponent {
  constructor(address world) BoolComponent(world, ID) {}
}
