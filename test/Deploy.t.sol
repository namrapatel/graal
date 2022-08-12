// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

import {DSTestPlus} from "solmate/test/utils/DSTestPlus.sol";

import { Deploy } from "./utils/Deploy.sol";
import { World } from "solecs/World.sol";
import { getComponentById } from "solecs/utils.sol";

contract DeployTest is DSTestPlus {
    Deploy internal deploy = new Deploy();
    address deployer = address(0);
    address world = address(1);

    function testDeploy() public {
        World world = deploy.deploy(deployer, world, true);
        IComponent component = getComponentById(world.components, uint256(keccak256("graal.component.Player"));
        console.log(component);
    }
}
