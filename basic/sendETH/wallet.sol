// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/**
 * @title Storage
 * @dev Store & retrieve value in a variable
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */

contract Wallet {
    address payable public owner;
    constructor () {
        owner = payable(msg.sender);
    }
    
    receive() external payable {}
    function withDraw(uint _amount) external {
        require(msg.sender==owner, "not owner");
        payable(msg.sender).transfer(_amount);
    }
    function getBalance() external view returns (uint) {
        return address(this).balance;
    }

}
