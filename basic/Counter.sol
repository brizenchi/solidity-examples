// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// data types - values and references

contract Counter {
    uint public count;

    function inc() external {
        count++;
    }
    function dec() external {
        count--;
    }    
}