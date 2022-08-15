// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.15;
pragma abicoder v2;

import { IUint256Component } from "solecs/interfaces/IUint256Component.sol";
import { getAddressById, addressToEntity } from "solecs/utils.sol";

import { PrototypeComponent, ID as PrototypeComponentID } from "../components/PrototypeComponent.sol";
import { OwnedByComponent, ID as OwnedByComponentID } from "../components/OwnedByComponent.sol";
import { RoomComponent, ID as RoomComponentID } from "../components/RoomComponent.sol";
import { RoomTypeComponent, ID as RoomTypeComponentID } from "../components/RoomTypeComponent.sol";
import { CommandsComponent, ID as CommandsComponentID } from "../components/CommandsComponent.sol";

import { Room, RoomType } from "../utils/Types.sol";

uint256 constant ID = uint256(keccak256("graal.prototype.GraalCity"));

function GraalCityPrototype(IUint256Component components) {
  OwnedByComponent(getAddressById(components, OwnedByComponentID)).set(ID, addressToEntity(address(0)));
  RoomComponent(getAddressById(components, RoomComponentID)).set(ID, uint32(Room.GraalCity));
  RoomTypeComponent(getAddressById(components, RoomTypeComponentID)).set(ID, uint32(RoomType.Corridor));

  string[] memory commands = new string[](1);
  commands[0] = "MoveTo";
  CommandsComponent(getAddressById(components, CommandsComponentID)).set(ID, commands);

  uint256[] memory componentIds = new uint256[](3);
  componentIds[2] = OwnedByComponentID;
  componentIds[3] = RoomComponentID;
  componentIds[4] = RoomTypeComponentID;
  componentIds[5] = CommandsComponentID;

  PrototypeComponent(getAddressById(components, PrototypeComponentID)).set(ID, componentIds);
}
