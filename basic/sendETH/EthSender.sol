// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract EthSender {
	constructor() payable {}

    receive() external payable {}

    function sendViaTransfer(address payable _to) external payable {
        _to.transfer(123);
    }

    function sendViaSend(address payable _to) external payable {
        bool sent = _to.send(123);
        require(sent, "send failed");
    }

    function sendViaCall(address payable _to) external payable {
        (bool success, ) = _to.call{value:123}("");
        require(success, "send failed");
    }
}

contract EthReceiver{
    event Log(uint amount, uint gas);
    receive() external payable {
        emit Log(msg.value, gasleft());
    }
}