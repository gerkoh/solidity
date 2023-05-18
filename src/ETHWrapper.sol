// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import {ERC20} from "../lib/forge-std/src/interfaces/IERC20.sol";

contract ETHWrapper is ERC20 {
    IERC20 public wrapppedtoken;

    mapping (address => uint256) public balances;

    event Deposit(address indexed recipient, uint256 amount);
    event Withdrawal(address indexed sender, uint256 amount);

    constructor(IERC20 wrappedtoken_, IERC20 ) public {
        wrapppedtoken = wrappedtoken_;
    }
}