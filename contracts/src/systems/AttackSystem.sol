// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.15;
import "solecs/System.sol";

import { IComponent } from "solecs/interfaces/IComponent.sol";
import { getAddressById, getComponentById, addressToEntity, getSystemAddressById } from "solecs/utils.sol";

import { PlayerComponent, ID as PlayerComponentID  } from "../components/PlayerComponent.sol";
import { LocationComponent, ID as LocationComponentID } from "../components/LocationComponent.sol";
import { OwnedByComponent, ID as OwnedByComponentID } from "../components/OwnedByComponent.sol";
import { MoveableComponent, ID as MoveableComponentID } from "../components/MoveableComponent.sol";
import { HealthComponent, ID as HealthComponentID, Health } from "../components/HealthComponent.sol";
import { RoomTypeComponent, ID as RoomTypeComponentID } from "../components/RoomTypeComponent.sol";

import { Room, RoomType } from "../utils/Types.sol";

uint256 constant ID = uint256(keccak256("graal.system.Attack"));

// Note: This is a v0, dummy AttackSystem for client-side testing purposes.
contract AttackSystem is System {
    constructor(IUint256Component _components, IWorld _world) System(_components, _world) {}

    function requirement(bytes memory arguments) public view returns (bytes memory) {
        (uint256 targetEntity) = abi.decode(arguments, (uint256));

        // Check that msg.sender is a playerEntity
        uint256 playerEntity = addressToEntity(msg.sender);
        require(PlayerComponent(getAddressById(components, PlayerComponentID)).has(playerEntity), "This entity is not a Player.");

        HealthComponent targetHealthComponent = HealthComponent(getAddressById(components, HealthComponentID));

        // Ensure target has health
        require(targetHealthComponent.has(targetEntity), "Target entity is does not have a HealthComponent.");

        // Check target health is not 0
        require(targetHealthComponent.getValue(targetEntity).current > 0, "Target entity has 0 health.");

        // Check that player is in the same room as the target
        uint32 playerLocation = LocationComponent(getAddressById(components, LocationComponentID)).getValue(playerEntity);
        uint32 targetLocation = LocationComponent(getAddressById(components, LocationComponentID)).getValue(targetEntity);
        require(playerLocation == targetLocation, "Player is not in the same room as the target.");

        // If target is a Fort, note this for the execute function
        bool targetIsFort = RoomTypeComponent(getAddressById(components, RoomTypeComponentID)).getValue(targetEntity) == uint32(RoomType.Fort);
        
        return abi.encode(targetEntity, playerEntity, targetIsFort, targetHealthComponent);
    }

    function execute(bytes memory arguments) public returns (bytes memory) {
        (uint256 targetEntity, uint256 playerEntity, bool targetIsFort, HealthComponent targetHealthComponent) = abi.decode(
            requirement(arguments), (uint256, uint256, bool, HealthComponent));

        if (targetIsFort) {
            // Player attacks the Fort
            Health memory newHealth = Health(0, 100);
            targetHealthComponent.set(targetEntity, newHealth);

            // Player is new owner of the Fort
            OwnedByComponent(getAddressById(components, OwnedByComponentID)).set(targetEntity, playerEntity);
        } else {
            // Player attacks the target
            Health memory newHealth = Health(0, 100);
            targetHealthComponent.set(targetEntity, newHealth);
        }
    }
}
