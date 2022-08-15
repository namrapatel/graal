// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.15;
import "solecs/System.sol";

import { IComponent } from "solecs/interfaces/IComponent.sol";
import { getAddressById, getComponentById, addressToEntity, getSystemAddressById } from "solecs/utils.sol";

import { PlayerComponent, ID as PlayerComponentID  } from "../components/PlayerComponent.sol";
import { LocationComponent, ID as LocationComponentID } from "../components/LocationComponent.sol";

import { Room } from "../utils/types.sol";

uint256 constant ID = uint256(keccak256("mudwar.system.PlayerJoin"));

contract PlayerJoinSystem is System {
  constructor(IUint256Component _components, IWorld _world) System(_components, _world) {}

  function requirement(bytes memory arguments) public view returns (bytes memory) {
    PlayerComponent playerComponent = PlayerComponent(getAddressById(components, PlayerComponentID));
    require(!playerComponent.has(addressToEntity(msg.sender)), "Player already spawned");

    return abi.encode(0); // TODO: Fix this to return the correct arguments
  }

  function execute(bytes memory arguments) public returns (bytes memory) {
    bytes memory temp = requirement(arguments);
    
    // Create player entity
    uint256 playerEntity = addressToEntity(msg.sender);
    PlayerComponent(getAddressById(components, PlayerComponentID)).set(playerEntity);

    // Spawn player in GraalCity
    LocationComponent(getAddressById(components, LocationComponentID)).set(playerEntity, uint32(Room.GraalCity));
  }
}