// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.15;

// Foundry
import {DSTestPlus} from "solmate/test/utils/DSTestPlus.sol";
import { Vm } from "forge-std/Vm.sol";
import { console } from "forge-std/console.sol";
import { Utilities } from "./Utilities.sol";
import { Cheats } from "./Cheats.sol";
import { World } from "solecs/World.sol";

// Libraries
import { LibDeploy, DeployResult } from "../../libraries/LibDeploy.sol";

contract Deploy is DSTestPlus {
  Cheats internal immutable vm = Cheats(HEVM_ADDRESS);
  Utilities internal immutable utils = new Utilities();
  address public deployer;
  World public world;

  function deploy(
    address _deployer,
    address _world,
    bool _reuseComponents
  ) public returns (World) {
    deployer = _deployer == address(0) ? utils.getNextUserAddress() : _deployer;
    vm.startPrank(_deployer);
    DeployResult memory result = LibDeploy.deploy(deployer, _world, _reuseComponents);
    vm.stopPrank();
    world = result.world;
    return world;
  }
}
