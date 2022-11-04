// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

abstract contract Abs {
    function getTag() public pure virtual returns(string memory);
}

contract AbsImpl is Abs {
    function getTag() public pure override returns(string memory) {
        return "wt";
    }
}