// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract ErrorImpl {

    error CCError(string value);

    event Success(string value);

    uint256 constant CORRECT = 245;

    function test1(uint256 _c) public {
        require(_c == CORRECT);
        emit Success("success 1");
    }

    function test2(uint256 _c) public {
        assert(_c == CORRECT);
        emit Success("success 2");
    }

    function test3(uint256 _c) public {
        if (_c != CORRECT) {
            revert CCError("error3, not valid num");
        } else {
            emit Success("success 3");
        }
    }


}