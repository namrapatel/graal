// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.15;
import "solecs/System.sol";

import { IComponent } from "solecs/interfaces/IComponent.sol";
import { getAddressById, getComponentById, addressToEntity, getSystemAddressById } from "solecs/utils.sol";
import { LibMove } from "../libraries/LibMove.sol";

import { PlayerComponent, ID as PlayerComponentID  } from "../components/PlayerComponent.sol";
import { LocationComponent, ID as LocationComponentID } from "../components/LocationComponent.sol";
import { OwnedByComponent, ID as OwnedByComponentID } from "../components/OwnedByComponent.sol";
import { MoveableComponent, ID as MoveableComponentID } from "../components/MoveableComponent.sol";

import { Room } from "../utils/Types.sol";

uint256 constant ID = uint256(keccak256("graal.system.Move"));

contract MoveSystem is System {
    constructor(IUint256Component _components, IWorld _world) System(_components, _world) {}

    function requirement(bytes memory arguments) public view returns (bytes memory) {
        (uint32 newLocation) = abi.decode(arguments, (uint32));
        uint256 playerEntity = addressToEntity(msg.sender);

        // Check entity is moveable
        MoveableComponent moveableComponent = MoveableComponent(getAddressById(components, MoveableComponentID));
        require(moveableComponent.has(playerEntity), "This entity is not Moveable");

        // Check if the desired move is valid
        uint32 currLocation = LocationComponent(getAddressById(components, LocationComponentID)).getValue(playerEntity); 
        require(currLocation != uint32(Room.None), "Player not spawned or is offline.");
        require(LibMove.checkMove(currLocation, newLocation), "Invalid move.");

        return abi.encode(newLocation, playerEntity); 
    }

    function execute(bytes memory arguments) public returns (bytes memory) {
        (uint32 newLocation, uint256 playerEntity) = abi.decode(arguments, (uint32, uint256));

        LocationComponent(getAddressById(components, LocationComponentID)).set(playerEntity, newLocation);
    }
}
