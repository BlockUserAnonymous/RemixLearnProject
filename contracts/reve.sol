// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract Rev {

    event Log(uint256 value, uint256 gas);
    receive() {
        emit Log(msg.value, gasleft());
    }
}