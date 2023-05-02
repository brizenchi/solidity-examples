// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// data types - values and references

contract ValueType {
    bool public b = true;
    function add(uint x, uint y) external pure returns (uint) {
        return x+y;
    }
    
}