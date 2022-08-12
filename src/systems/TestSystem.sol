// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.15;
import "solecs/System.sol";

uint256 constant ID = uint256(keccak256("graal.system.Test"));

contract TestSystem is System {
  constructor(IUint256Component _components, IWorld _world) System(_components, _world) {}

  function requirement(bytes memory) public view returns (bytes memory) {
    require(msg.sender == _owner, "only owner can initialize");
  }

  function execute(bytes memory) public returns (bytes memory) {
  }
}
