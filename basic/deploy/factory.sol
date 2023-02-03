// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/**
 * @title Storage
 * @dev Store & retrieve value in a variable
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
contract Account {
    address public bank;
    address public owner;
    constructor(address _owner) payable{
        bank = msg.sender;
        owner = _owner;
    }
}

contract AccountFactory {
    Account[] public accounts;
   
    function createAccount(address _owner) external payable {
        Account account = new Account{value:111}(_owner);
        accounts.push(account);
    }
}
