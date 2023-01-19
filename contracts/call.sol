// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract OtherContract {

    uint256 private _x = 0;

    event Logs(uint256 amount, uint256 gas);

    function getETHBalance() external view returns(uint256) {
        return address(this).balance;
    }

    function get_x() external view returns(uint256) {
        return _x;
    }

    function set_x(uint amount) external payable {
        _x = amount;
        if (msg.value > 0) {
            emit Logs(msg.value, gasleft());
        }
    }

    // fallback() external payable{}
}

contract CallContract {

    event Response(bool successs, bytes data);

    function getBalance(address payable _address) external view returns(uint256) {
        return OtherContract(_address).getETHBalance();
    }

    function callSetX(address payable _addr, uint256 amount) public payable {
        (bool success, bytes memory data) = _addr.call{value: msg.value} (
            abi.encodeWithSignature("set_y(unit amount)", amount)
        );
        emit Response(success, data);
    }
}