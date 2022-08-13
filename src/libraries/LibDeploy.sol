// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

// Foundry
import { console } from "forge-std/console.sol";
import { Cheats } from "../../test/utils/Cheats.sol";

// Solecs 
import { World } from "solecs/World.sol";
import { Component } from "solecs/Component.sol";
import { getAddressById } from "solecs/utils.sol";
import { IUint256Component } from "solecs/interfaces/IUint256Component.sol";
import { ISystem } from "solecs/interfaces/ISystem.sol";

// Components
import { AttackComponent, ID as AttackComponentID } from "../components/AttackComponent.sol";
import { CaptureableComponent, ID as CaptureableComponentID } from "../components/CaptureableComponent.sol";
import { HealthComponent, ID as HealthComponentID } from "../components/HealthComponent.sol";
import { OwnedByComponent, ID as OwnedByComponentID } from "../components/OwnedByComponent.sol";
import { PlayerComponent, ID as PlayerComponentID } from "../components/PlayerComponent.sol";

// Systems
import { InitSystem, ID as InitSystemID } from "../systems/InitSystem.sol";
import { TestSystem, ID as TestSystemID } from "../systems/TestSystem.sol";

struct DeployResult {
  World world;
  address deployer;
}

library LibDeploy {

  function deploy(
    address _deployer,
    address _world,
    bool _reuseComponents
  ) internal returns (DeployResult memory result) {
    result.deployer = _deployer;

    // ------------------------
    // Deploy 
    // ------------------------

    // Deploy world
    result.world = _world == address(0) ? new World() : World(_world);
    if(_world == address(0)) result.world.init(); // Init if it's a fresh world

      // Deploy components
    if(!_reuseComponents) {
      Component comp;

      console.log("Deploying AttackComponent");
      comp = new AttackComponent(address(result.world));
      console.log(address(comp));

      console.log("Deploying CaptureableComponent");
      comp = new CaptureableComponent(address(result.world));
      console.log(address(comp));

      console.log("Deploying HealthComponent");
      comp = new HealthComponent(address(result.world));
      console.log(address(comp));

      console.log("Deploying OwnedByComponent");
      comp = new OwnedByComponent(address(result.world));
      console.log(address(comp));

      console.log("Deploying PlayerComponent");
      comp = new PlayerComponent(address(result.world));
      console.log(address(comp));

    } 
    
    deploySystems(address(result.world), true);
  }
    
  
  function authorizeWriter(IUint256Component components, uint256 componentId, address writer) internal {
    Component(getAddressById(components, componentId)).authorizeWriter(writer);
  }
  
  function deploySystems(address _world, bool init) internal {
    World world = World(_world);
    // Deploy systems
    ISystem system; 
    IUint256Component components = world.components();

    console.log("Deploying InitSystem");
    system = new InitSystem(components, world);
    world.registerSystem(address(system), InitSystemID);
    authorizeWriter(components, AttackComponentID, address(system));
    authorizeWriter(components, CaptureableComponentID, address(system));
    authorizeWriter(components, HealthComponentID, address(system));
    authorizeWriter(components, OwnedByComponentID, address(system));
    authorizeWriter(components, PlayerComponentID, address(system));
    if(init) system.execute(new bytes(0));
    console.log(address(system));

    console.log("Deploying TestSystem");
    system = new TestSystem(components, world);
    world.registerSystem(address(system), TestSystemID);
    authorizeWriter(components, AttackComponentID, address(system));
    authorizeWriter(components, CaptureableComponentID, address(system));
    authorizeWriter(components, HealthComponentID, address(system));
    authorizeWriter(components, OwnedByComponentID, address(system));
    authorizeWriter(components, PlayerComponentID, address(system));
    console.log(address(system));

  }
}