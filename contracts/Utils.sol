// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Utils {
    // 160 - 502902819105911346612874051845184653903825988289
    // 16 - 60097
    function convert160(address addr) external pure returns(uint160) {
        return uint160(addr);
    }

    function convert16(uint160 value) external pure returns(uint16) {
        return uint16(value);
    }

    function uint64touint32(uint64 _value) external pure returns(uint32) {
        return uint32(_value);
    }
}