// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import {IERC20} from "../lib/forge-std/src/interfaces/IERC20.sol";

contract BasicVault {
    
    // STATE VARS:

    // token
    IERC20 public token;

    // mapping to serve as balances registry
    mapping (address => uint256) public balances;

    // events 
    event Deposit(address indexed recipient, uint256 amount);
    event Withdrawal(address indexed sender, uint256 amount);
    
    // constructor function
    constructor(IERC20 token_) public {
        token = token_;
    }

    // deposit function
    // transferFrom is initiated by the recipient
    // transfer is initiated by the sender
    function deposit(uint256 amount) public {
        // balances[address[this]] -= amount;
        balances[msg.sender] += amount; // record keeping
        bool success = token.transferFrom(msg.sender, address(this), amount); // actual transfer
        require(success, "Insufficient balance");
        emit Deposit(msg.sender, amount);
    }
    

    // withdraw function
    function withdrawal(uint256 amount) public {
        balances[msg.sender] -= amount;
        bool success = token.transfer(msg.sender, amount);
        require(success, "Insufficient balance");
        emit Withdrawal(msg.sender, amount);       
    }
    
}