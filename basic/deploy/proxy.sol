// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract TestContract1 {
    address public owner = msg.sender;
    function setOwner(address _owner) public payable {
        require(msg.sender == owner, "not owner");
        owner = _owner;
    }
}
contract TestContract2 {
    address public owner = msg.sender;
    uint public x;
    uint public y;
    constructor(uint _x, uint _y) payable {
        x = _x;
        y = _y;
    }
}
contract Proxy {
    function deploy() external payable {
        new TestContract1();
    }
}
contract Owner {

    event Deploy(address);

    function deploy(bytes memory _code) external payable returns (address) {
        address addr;
        assembly {
            // create(v, p, n) 
            // v：消息发送的主币
            // p：机器码开始的位置
            // n：size of code
            addr := create(callvalue(), add(_code, 0x20), mload(_code))
        }
        require(addr != address(0), "deploy failed");
        emit Deploy(addr);
        return addr;
    }

    function execute(address _target, bytes memory _data) external payable {
        (bool success, ) = _target.call{value: msg.value}(_data);
        require(success, "failed");
    }

}
contract Helper {

    function getBytecode1() external pure returns (bytes memory) {
        bytes memory bytecode = type(TestContract1).creationCode;
        return bytecode;  // x, y 构造函数内容
    }

    function getBytecode2(uint _x, uint _y) external pure returns (bytes memory) {
        bytes memory bytecode = type(TestContract2).creationCode;
        return abi.encodePacked(bytecode, abi.encode(_x, _y));  // x, y 构造函数内容
    }
   
   function getCalldata(address _owner) external pure returns (bytes memory ) {
       return abi.encodeWithSignature("setOwner(address)", _owner);
   }

}