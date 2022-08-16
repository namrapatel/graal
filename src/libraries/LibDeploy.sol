// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.15;

// Foundry
import { console } from "forge-std/console.sol";

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
import { LocationComponent, ID as LocationComponentID } from "../components/LocationComponent.sol";
import { MoveableComponent, ID as MoveableComponentID } from "../components/MoveableComponent.sol";
import { OwnedByComponent, ID as OwnedByComponentID } from "../components/OwnedByComponent.sol";
import { PlayerComponent, ID as PlayerComponentID } from "../components/PlayerComponent.sol";
import { PrototypeComponent, ID as PrototypeComponentID } from "../components/PrototypeComponent.sol";
import { RoomComponent, ID as RoomComponentID } from "../components/RoomComponent.sol";
import { RoomTypeComponent, ID as RoomTypeComponentID } from "../components/RoomTypeComponent.sol";

// Systems
import { AttackSystem, ID as AttackSystemID } from "../systems/AttackSystem.sol";
import { InitSystem, ID as InitSystemID } from "../systems/InitSystem.sol";
import { MoveSystem, ID as MoveSystemID } from "../systems/MoveSystem.sol";
import { PlayerJoinSystem, ID as PlayerJoinSystemID } from "../systems/PlayerJoinSystem.sol";

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

      console.log("Deploying LocationComponent");
      comp = new LocationComponent(address(result.world));
      console.log(address(comp));

      console.log("Deploying MoveableComponent");
      comp = new MoveableComponent(address(result.world));
      console.log(address(comp));

      console.log("Deploying OwnedByComponent");
      comp = new OwnedByComponent(address(result.world));
      console.log(address(comp));

      console.log("Deploying PlayerComponent");
      comp = new PlayerComponent(address(result.world));
      console.log(address(comp));

      console.log("Deploying PrototypeComponent");
      comp = new PrototypeComponent(address(result.world));
      console.log(address(comp));

      console.log("Deploying RoomComponent");
      comp = new RoomComponent(address(result.world));
      console.log(address(comp));

      console.log("Deploying RoomTypeComponent");
      comp = new RoomTypeComponent(address(result.world));
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

    console.log("Deploying AttackSystem");
    system = new AttackSystem(components, world);
    world.registerSystem(address(system), AttackSystemID);
    authorizeWriter(components, HealthComponentID, address(system));
    authorizeWriter(components, OwnedByComponentID, address(system));
    console.log(address(system));

    console.log("Deploying InitSystem");
    system = new InitSystem(components, world);
    world.registerSystem(address(system), InitSystemID);
    authorizeWriter(components, AttackComponentID, address(system));
    authorizeWriter(components, CaptureableComponentID, address(system));
    authorizeWriter(components, HealthComponentID, address(system));
    authorizeWriter(components, LocationComponentID, address(system));
    authorizeWriter(components, MoveableComponentID, address(system));
    authorizeWriter(components, OwnedByComponentID, address(system));
    authorizeWriter(components, PlayerComponentID, address(system));
    authorizeWriter(components, PrototypeComponentID, address(system));
    authorizeWriter(components, RoomComponentID, address(system));
    authorizeWriter(components, RoomTypeComponentID, address(system));
    if(init) system.execute(new bytes(0));
    console.log(address(system));

    console.log("Deploying MoveSystem");
    system = new MoveSystem(components, world);
    world.registerSystem(address(system), MoveSystemID);
    authorizeWriter(components, LocationComponentID, address(system));
    console.log(address(system));

    console.log("Deploying PlayerJoinSystem");
    system = new PlayerJoinSystem(components, world);
    world.registerSystem(address(system), PlayerJoinSystemID);
    authorizeWriter(components, PlayerComponentID, address(system));
    authorizeWriter(components, LocationComponentID, address(system));
    authorizeWriter(components, OwnedByComponentID, address(system));
    authorizeWriter(components, MoveableComponentID, address(system));
    console.log(address(system));

  }
}