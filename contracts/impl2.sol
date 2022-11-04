// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

interface Inter {
    function getTag() external pure returns(string memory);
}

contract InterImpl is Inter {
    function getTag() external pure override returns(string memory) {
        return "impl";
    }
}