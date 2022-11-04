// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract GraPa {
    event Log(string msg);

    function init() public virtual {
        emit Log("gra pa");
    }


}

contract Fat is GraPa {

    uint256 public a;
    constructor(uint256 _a) {
        a = _a;
    } 
    function init() public virtual override {
        emit Log("Fat");
    }

    function say() public virtual {
        emit Log("say fat");
    }
}

contract Son is GraPa, Fat {

    string public c;
    constructor(uint256 _a, string memory _c) Fat(_a) {
        c = _c;
    }

    function init() public override(GraPa, Fat) {
        emit Log("Son");
    }

    function say() public override {
        emit Log("say son");
    }
}