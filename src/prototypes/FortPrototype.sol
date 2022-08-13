// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.15;

import { IUint256Component } from "solecs/interfaces/IUint256Component.sol";
import { getAddressById, addressToEntity } from "solecs/utils.sol";

import { PrototypeComponent, ID as PrototypeComponentID } from "../components/PrototypeComponent.sol";
import { CaptureableComponent, ID as CaptureableComponentID } from "../components/CaptureableComponent.sol";
import { OwnedByComponent, ID as OwnedByComponentID } from "../components/OwnedByComponent.sol";
import { HealthComponent, ID as HealthComponentID, Health } from "../components/HealthComponent.sol";

uint256 constant ID = uint256(keccak256("graal.prototype.Fort"));

function FortPrototype(IUint256Component components) {
  HealthComponent(getAddressById(components, HealthComponentID)).set(ID, Health({ current: 100_000, max: 100_000 }));
  CaptureableComponent(getAddressById(components, CaptureableComponentID)).set(ID);
  OwnedByComponent(getAddressById(components, OwnedByComponentID)).set(ID, addressToEntity(address(0)));

  uint256[] memory componentIds = new uint256[](3);
  componentIds[0] = HealthComponentID;
  componentIds[1] = CaptureableComponentID;
  componentIds[2] = OwnedByComponentID;

  PrototypeComponent(getAddressById(components, PrototypeComponentID)).set(ID, componentIds);
}
