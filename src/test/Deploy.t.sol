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
import { AttackSystem, ID as AttackSystemID } from "../systems/AttackSystem.sol";

contract DeployTest is DSTest {
    address internal deployer;

    World internal world;
    IUint256Component components;
    IUint256Component systems;
    Deploy internal deploy = new Deploy();

    function setUp() public {
        world = deploy.deploy(address(0), address(0), false);
        components = world.components();
        systems = world.systems();
        deployer = deploy.deployer();
    }

    function testComponentDeployed() public view {
        uint256 locationComponent = addressToEntity(address(LocationComponent(getAddressById(components, LocationComponentID))));     

        uint256 fakeEntity = uint256(0);
        require(components.has(locationComponent), "Component not registered.");
        require(!components.has(fakeEntity), "Component registration not working.");
        console.log("Component registration working.");
    }

    function testSystemDeployed() public view {
        uint256 attackSystem = addressToEntity(address(AttackSystem(getAddressById(systems, AttackSystemID))));     

        uint256 fakeEntity = uint256(0);
        require(systems.has(attackSystem), "System not registered.");
        require(!systems.has(fakeEntity), "System registration not working.");
        console.log("System registration working.");
    }
}
