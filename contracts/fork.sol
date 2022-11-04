// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract OtherContract {

    
    uint256 private _x = 100;

    event Logs(uint256 amount, uint256 gas);

    function get_x() external view returns(uint256) {
        return _x;
    }

    function set_x(uint256 x) external payable {
        _x = x;
        if (msg.value > 0) {
            emit Logs(msg.value, gasleft());
        }
    }
}


contract ForkContract {
    function set_x_2_other(address payable _address, uint256 value) external payable {
        OtherContract(_address).set_x(value);
    }

    function set_x_2_other_with_eth(address payable _address, uint256 amount) external payable {
        OtherContract(_address).set_x{value: msg.value}(amount);
    }

    function get_x_by_contract(OtherContract _address) external view returns(uint256) {
        return _address.get_x();
    }

    function get_x_by_address(address _address) external view returns(uint256) {
        return OtherContract(_address).get_x();
    }
}