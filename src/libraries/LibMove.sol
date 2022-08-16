// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.15;

import { Room } from "../utils/Types.sol";

library LibMove {

    function checkMove(uint32 currLocation, uint32 newLocation) public pure returns(bool) {
        if ((currLocation == uint32(Room.GraalCity)) && (newLocation != uint32(Room.RiverAlley))) {
            return true;
        } else if ((currLocation == uint32(Room.RiverAlley)) && 
                    (newLocation == (uint32(Room.Castle)) || 
                    newLocation == (uint32(Room.Swamptown)))) {
            return true;
        } else if ((currLocation == uint32(Room.Sardons)) && (newLocation == uint32(Room.GraalCity))) {
            return true;
        } else if ((currLocation == uint32(Room.Castle)) && 
                    (newLocation == uint32(Room.GraalCity) ||
                    newLocation == uint32(Room.RiverAlley))) {
            return true;
        } else if ((currLocation == uint32(Room.MoD)) && (newLocation == uint32(Room.GraalCity))) {
            return true;
        } else if ((currLocation == uint32(Room.Swamptown)) && 
                    (newLocation ==  uint32(Room.GraalCity)|| 
                    newLocation == uint32(Room.RiverAlley))) {
            return true;
        } else {
            return false;
        }
    }

}