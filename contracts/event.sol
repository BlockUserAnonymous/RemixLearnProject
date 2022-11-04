// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract EventC {

    mapping(address=>uint256) balances;

    event Trans(address indexed from, address indexed to, uint256 value);

    function _transfer (
        address from,
        address to,
        uint256 value
    ) external {
        balances[from] -= value;
        balances[to] += value;
        emit Trans(from, to, value);
    }

    function _addBalance(address ads) external {
        balances[ads] += 10000;
    
    }
}