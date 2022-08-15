// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.15;
pragma abicoder v2;

import { IUint256Component } from "solecs/interfaces/IUint256Component.sol";
import { getAddressById, addressToEntity } from "solecs/utils.sol";

import { PrototypeComponent, ID as PrototypeComponentID } from "../components/PrototypeComponent.sol";
import { CaptureableComponent, ID as CaptureableComponentID } from "../components/CaptureableComponent.sol";
import { OwnedByComponent, ID as OwnedByComponentID } from "../components/OwnedByComponent.sol";
import { HealthComponent, ID as HealthComponentID, Health } from "../components/HealthComponent.sol";
import { RoomComponent, ID as RoomComponentID } from "../components/RoomComponent.sol";
import { RoomTypeComponent, ID as RoomTypeComponentID } from "../components/RoomTypeComponent.sol";
import { CommandsComponent, ID as CommandsComponentID } from "../components/CommandsComponent.sol";

import { Room, RoomType } from "../utils/Types.sol";

uint256 constant ID = uint256(keccak256("graal.prototype.SardonsFort"));

function SardonsFortPrototype(IUint256Component components) {
  HealthComponent(getAddressById(components, HealthComponentID)).set(ID, Health({ current: 100_000, max: 100_000 }));
  CaptureableComponent(getAddressById(components, CaptureableComponentID)).set(ID);
  OwnedByComponent(getAddressById(components, OwnedByComponentID)).set(ID, addressToEntity(address(0)));
   RoomComponent(getAddressById(components, RoomComponentID)).set(ID, uint32(Room.Sardons));
  RoomTypeComponent(getAddressById(components, RoomTypeComponentID)).set(ID, uint32(RoomType.Fort));
  string[] memory commands = new string[](3);
  commands[0] = "Attack";
  commands[1] = "Defend";
  commands[2] = "MoveTo";
  CommandsComponent(getAddressById(components, CommandsComponentID)).set(ID, commands);


  uint256[] memory componentIds = new uint256[](3);
  componentIds[0] = HealthComponentID;
  componentIds[1] = CaptureableComponentID;
  componentIds[2] = OwnedByComponentID;
  componentIds[3] = RoomComponentID;
  componentIds[4] = RoomTypeComponentID;
  componentIds[5] = CommandsComponentID;

  PrototypeComponent(getAddressById(components, PrototypeComponentID)).set(ID, componentIds);
}
