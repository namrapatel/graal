// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

import { DSTest } from "ds-test/test.sol";

import { Deploy } from "./utils/Deploy.sol";
import { World } from "solecs/World.sol";
import { getComponentById, getAddressById, addressToEntity } from "solecs/utils.sol";
import { IComponent } from "solecs/interfaces/IComponent.sol";
import { IUint256Component } from "solecs/interfaces/IUint256Component.sol";
import { console } from "forge-std/console.sol";
import { LocationComponent, ID as LocationComponentID } from "../components/LocationComponent.sol";

contract DeployTest is DSTest {
    Deploy internal deploy = new Deploy();
    address deployerAddress = address(0);
    address worldAddress = address(99);

    function testDeploy() public {
        World world = deploy.deploy(deployerAddress, worldAddress, true);
        IUint256Component components = world.components();

        uint256 locationComponent = addressToEntity(address(LocationComponent(getAddressById(components, LocationComponentID))));     

        uint256 fakeEntity = uint256(0);
        require(components.has(locationComponent), "Component not registered.");
        require(!components.has(fakeEntity), "Component registration not working.");
        console.log("Component registration working.");
    }
}
