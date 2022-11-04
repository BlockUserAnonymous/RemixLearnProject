// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract Const {
    uint256 public constant NUM = 101;

    uint256 public immutable KEY;



    constructor() {
        KEY = 235;
    }
}