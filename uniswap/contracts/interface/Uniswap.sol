// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

interface IUniswapV2Router{
    function swapExpectTokensForTokens(
        uint256 amountIn,
        uint256 amoutOut,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);
}